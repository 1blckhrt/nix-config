{
  config,
  pkgs,
  lib,
  ...
}: let
  # Configuration variables
  repoUrl = "https://github.com/1blckhrt/notes-public.git";
  siteName = "Personal Knowledge Base";
  hugoPort = "1313";
  nginxPort = "8080";

  # Hugo site directory
  siteDir = "${config.home.homeDirectory}/.local/share/hugo-site";

  # Nginx directories
  nginxDir = "${config.home.homeDirectory}/.local/share/nginx";
  nginxLogDir = "${nginxDir}/logs";
  nginxTempDir = "${nginxDir}/temp";
  nginxPidFile = "${nginxDir}/nginx.pid";

  # PaperMod theme configuration
  hugoConfigContent = ''
    baseURL = 'http://localhost:${nginxPort}'
    languageCode = 'en-us'
    title = '${siteName}'
    theme = 'PaperMod'

    [menu]
      [[menu.main]]
        name = "Home"
        url = "/"
        weight = 1

      [[menu.main]]
        name = "Notes"
        url = "/notes/"
        weight = 2

    [caches]
      [caches.images]
        dir = ':cacheDir/images'

    [taxonomies]
      category = "categories"
      tag = "tags"

    [params]
      defaultTheme = "auto"
      disableThemeToggle = true
      ShowShareButtons = false
      ShowReadingTime = true
      disableSpecial1stPost = false
      displayFullLangName = false
      ShowPostNavLinks = true
      ShowBreadCrumbs = true
      ShowCodeCopyButtons = true
      ShowWordCount = true
      ShowRssButtonInSectionTermList = true
      UseHugoToc = true
      disableScrollToTop = false

    [outputs]
      home = ["HTML", "RSS", "JSON"]
  '';

  # Script to clone/update repo and build site
  buildSiteScript = pkgs.writeShellScript "build-hugo-site" ''
        set -e

        echo "Setting up Hugo site..."

        # Create site directory if it doesn't exist
        mkdir -p ${siteDir}

        # Clone or update the repository
        if [ -d "${siteDir}/.git" ]; then
          echo "Updating existing repository..."
          cd ${siteDir}
          ${pkgs.git}/bin/git pull origin main || ${pkgs.git}/bin/git pull origin master

          # Update submodules (including the PaperMod theme)
          echo "Updating submodules..."
          ${pkgs.git}/bin/git submodule update --init --recursive
        else
          echo "Cloning repository: ${repoUrl}"
          ${pkgs.git}/bin/git clone --recurse-submodules ${repoUrl} ${siteDir}
          cd ${siteDir}
        fi

        # Check if PaperMod theme exists, if not clone it manually
        if [ ! -d "${siteDir}/themes/PaperMod" ]; then
          echo "PaperMod theme not found, cloning manually..."
          mkdir -p ${siteDir}/themes
          cd ${siteDir}/themes
          ${pkgs.git}/bin/git clone https://github.com/adityatelange/hugo-PaperMod.git PaperMod
          cd ${siteDir}
        fi

        # Check if Hugo config exists, if not create it
        if [ ! -f "hugo.toml" ] && [ ! -f "config.toml" ] && [ ! -f "config.yaml" ] && [ ! -f "config.yml" ]; then
          echo "No Hugo config found, creating config.toml..."
          cat > config.toml << 'EOF'
    ${hugoConfigContent}
    EOF
        fi

        # Create content directory if it doesn't exist
        mkdir -p content/notes

        # Create _index.md for notes section if it doesn't exist
        if [ ! -f "content/notes/_index.md" ]; then
          echo "Creating notes index page..."
          cat > content/notes/_index.md << 'EOF'
    ---
    title: "Notes"
    ---
    Welcome to my notes collection.
    EOF
        fi

        # Create a sample note if no notes exist
        if [ ! -f "content/notes/"*.md ] || [ ! -f "content/notes/"*.md ]; then
          echo "Creating sample note..."
          cat > content/notes/first-note.md << 'EOF'
    ---
    title: "First Note"
    date: $(date -I)
    draft: false
    tags: [sample, hello]
    categories: [General]
    ---
    # My First Note

    This is my first note in the knowledge base.

    - Item one
    - Item two
    - Item three
    EOF
        fi

        # Build the site
        echo "Building Hugo site..."
        ${pkgs.hugo}/bin/hugo --minify --destination public

        echo "Site built successfully at ${siteDir}/public"
  '';

  # Script to start Hugo server
  startHugoServerScript = pkgs.writeShellScript "start-hugo-server" ''
    set -e

    echo "Starting Hugo server on port ${hugoPort}..."
    cd ${siteDir}
    ${pkgs.hugo}/bin/hugo server --port ${hugoPort} --bind 0.0.0.0
  '';

  # Nginx configuration
  nginxConfig = pkgs.writeText "nginx.conf" ''
    worker_processes 1;
    pid ${nginxPidFile};
    error_log ${nginxLogDir}/error.log;

    events {
        worker_connections 1024;
    }

    http {
        include ${pkgs.nginx}/conf/mime.types;
        default_type application/octet-stream;
        access_log ${nginxLogDir}/access.log;
        sendfile on;
        keepalive_timeout 65;

        server {
            listen ${nginxPort};
            server_name localhost;
            root ${siteDir}/public;
            index index.html;

            location / {
                try_files $uri $uri/ =404;
            }

            location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg)$ {
                expires 1y;
                add_header Cache-Control "public, immutable";
            }
        }
    }
  '';

  # Script to start nginx
  startNginxScript = pkgs.writeShellScript "start-nginx" ''
    set -e

    # Create nginx directories
    mkdir -p ${nginxLogDir} ${nginxTempDir}

    echo "Starting nginx on port ${nginxPort}..."
    ${pkgs.nginx}/bin/nginx -c ${nginxConfig} -p ${nginxDir}
    echo "Nginx started. Site available at: http://localhost:${nginxPort}"
  '';

  # Script to stop nginx
  stopNginxScript = pkgs.writeShellScript "stop-nginx" ''
     if [ -f ${nginxPidFile} ]; then
       echo "Stopping nginx..."
    pkill nginx
       ${pkgs.nginx}/bin/nginx -s quit -c ${nginxConfig} -p ${nginxDir}
       echo "Nginx stopped."
     else
       echo "Nginx is not running."
     fi
  '';

  # Script for hourly refresh (stop-nginx, clean, nginx)
  hourlyRefreshScript = pkgs.writeShellScript "hourly-refresh" ''
    echo "Starting hourly refresh at $(date)"
    echo "Stopping nginx..."
    ${stopNginxScript}
    echo "Cleaning up..."
    rm -rf ${siteDir}/public
    echo "Building and starting nginx..."
    ${buildSiteScript}
    ${startNginxScript}
    echo "Hourly refresh completed at $(date)"
  '';

  # Main executable script
  mainScript = pkgs.writeShellScript "hugo-site-manager" ''
    #!/usr/bin/env bash

    case "$1" in
      build)
        echo "Building Hugo site from repository..."
        ${buildSiteScript}
        ;;
      start)
        echo "Building and starting Hugo development server..."
        ${buildSiteScript}
        ${startHugoServerScript}
        ;;
      nginx)
        echo "Building site and starting nginx..."
        ${buildSiteScript}
        ${startNginxScript}
        ;;
      stop-nginx)
        echo "Stopping nginx..."
        ${stopNginxScript}
        ;;
      clean)
        echo "Cleaning up..."
        ${stopNginxScript}
        rm -rf ${siteDir}/public
        echo "Cleanup complete"
        ;;
      hourly-refresh)
        echo "Running hourly refresh..."
        ${hourlyRefreshScript}
        ;;
      *)
        echo "Usage: $0 {build|start|nginx|stop-nginx|clean|hourly-refresh}"
        echo ""
        echo "Commands:"
        echo "  build          - Clone/update repository and build Hugo site"
        echo "  start          - Build site and start Hugo development server (port ${hugoPort})"
        echo "  nginx          - Build site and start nginx server (port ${nginxPort})"
        echo "  stop-nginx     - Stop nginx server"
        echo "  clean          - Stop nginx and clean built files"
        echo "  hourly-refresh - Run stop-nginx, clean, and nginx (for systemd)"
        echo ""
        echo "Configuration:"
        echo "  Repository: ${repoUrl}"
        echo "  Site directory: ${siteDir}"
        exit 1
        ;;
    esac
  '';
in {
  # Install required packages
  home.packages = with pkgs; [
    git
    hugo
    nginx
  ];

  # Create the executable script
  home.file."bin/hugo-site-manager" = {
    source = mainScript;
    executable = true;
  };

  # Add script directory to PATH
  home.sessionPath = ["${config.home.homeDirectory}/bin"];

  # Systemd service for hourly refresh
  systemd.user.services.hugo-hourly-refresh = {
    Unit = {
      Description = "Hourly refresh of Hugo site with nginx";
      After = ["network.target"];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${mainScript} hourly-refresh";
      Environment = "PATH=${lib.makeBinPath [pkgs.git pkgs.hugo pkgs.nginx]}";
    };

    Install = {
      WantedBy = ["multi-user.target"];
    };
  };

  # Systemd timer for hourly execution
  systemd.user.timers.hugo-hourly-refresh = {
    Unit = {
      Description = "Timer for hourly Hugo site refresh";
    };

    Timer = {
      OnCalendar = "hourly";
      Persistent = true;
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };

  systemd.user.services.hugo-site = {
    Unit = {
      Description = "Hugo Site with nginx";
      After = ["network.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${mainScript} nginx";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };
}
