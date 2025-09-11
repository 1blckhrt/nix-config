{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.notesSite;

  buildScript = pkgs.writeShellScript "notesSite-build" ''
        set -euo pipefail
        echo "Building Hugo site at ${cfg.buildDir}..."

        mkdir -p ${cfg.buildDir}
        cd ${cfg.buildDir}

        # Clone or update repository (use absolute path to git)
        if [ -d ".git" ]; then
          echo "Updating repository..."
          ${pkgs.git}/bin/git pull origin ${cfg.branch}
        else
          echo "Cloning repository..."
          ${pkgs.git}/bin/git clone --branch ${cfg.branch} ${cfg.repoUrl} .
        fi

        # Set up Hugo theme
        mkdir -p themes
        if [ -d "themes/hello-friend-ng" ]; then
          echo "Updating Hugo theme..."
          cd themes/hello-friend-ng
          ${pkgs.git}/bin/git pull origin master
          cd ../..
        else
          echo "Cloning Hugo theme..."
          ${pkgs.git}/bin/git clone https://github.com/rhazdon/hugo-theme-hello-friend-ng.git themes/hello-friend-ng
        fi

        # Generate config.toml if missing
        if [ ! -f "config.toml" ]; then
          echo "Generating basic Hugo configuration..."
          cat > config.toml <<EOF
    baseURL = "${
      if cfg.baseURL != null
      then cfg.baseURL
      else "/"
    }"
    languageCode = "en-us"
    title = "${cfg.siteTitle}"
    theme = "hello-friend-ng"

    [params]
      homeSubtitle = "${cfg.subtitle}"
      enableSharingButtons = true
      enableReadingTime = false

    [taxonomies]
      category = "categories"
      tag      = "tags"
      series   = "series"

    [permalinks]
      ${cfg.notesDirectory} = "/${cfg.notesDirectory}/:title/"

    [languages]
      [languages.en]
        subtitle = "${cfg.subtitle}"
    EOF
        fi

        # Determine BASEURL_ARG safely at Nix evaluation time
        BASEURL_ARG=${
      if cfg.baseURL != null
      then "--baseURL ${cfg.baseURL}"
      else ""
    };

        # Build Hugo site (use absolute path to hugo)
        mkdir -p ${cfg.outputDir}
        ${pkgs.hugo}/bin/hugo --minify --destination ${cfg.outputDir} $BASEURL_ARG

        # Fix permissions
        chown -R ${cfg.user}:${cfg.group} ${cfg.outputDir}
        chmod -R g+rX ${cfg.outputDir}

        echo "Build complete!"
  '';
in {
  options.services.notesSite = {
    enable = lib.mkEnableOption "Notes Hugo site";

    repoUrl = lib.mkOption {
      type = lib.types.str;
      description = "URL of the GitHub repository containing your notes";
    };

    branch = lib.mkOption {
      type = lib.types.str;
      default = "main";
      description = "Git branch to pull from";
    };

    buildDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/notes-site/repo";
      description = "Directory where the repository will be cloned";
    };

    outputDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/notes-site/public";
      description = "Directory where Hugo outputs the site";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "notes-site";
      description = "User to run the service as";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "notes-site";
      description = "Group to run the service as";
    };

    domain = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Domain name for the site";
    };

    baseURL = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Base URL for Hugo (optional)";
    };

    siteTitle = lib.mkOption {
      type = lib.types.str;
      default = "My Notes";
      description = "Title of the site";
    };

    subtitle = lib.mkOption {
      type = lib.types.str;
      default = "Personal knowledge base";
      description = "Subtitle of the site";
    };

    notesDirectory = lib.mkOption {
      type = lib.types.str;
      default = "notes";
      description = "Directory name for notes";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 80;
      description = "Port for Nginx to listen on";
    };

    updateInterval = lib.mkOption {
      type = lib.types.str;
      default = "10m";
      description = "Interval for periodic site updates (systemd timer)";
    };
  };

  config = lib.mkIf cfg.enable {
    # System user and group
    users.groups.${cfg.group} = {};
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      home = "/var/lib/notes-site";
      createHome = true;
    };

    # Ensure nginx can read the site by adding it to the notes-site group
    users.users.nginx.extraGroups = [cfg.group];

    # Ensure directories exist with correct owner/group/mode on boot
    systemd.tmpfiles.rules = lib.mkForce [
      "d /var/lib/notes-site 0755 ${cfg.user} ${cfg.group} -"
      "d ${cfg.buildDir} 0755 ${cfg.user} ${cfg.group} -"
      # public dir: setgid so files created there inherit the group (2xxx bit)
      "d ${cfg.outputDir} 2755 ${cfg.user} ${cfg.group} -"
      # ensure index.html is group-readable (won't error if missing)
      "f ${cfg.outputDir}/index.html 0644 ${cfg.user} ${cfg.group} -"
    ];

    # Initial build service
    systemd.services.notesSiteBuild = {
      description = "Build Hugo notes site";
      serviceConfig = {
        Type = "oneshot";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${buildScript}";
      };
      wantedBy = ["multi-user.target"];
      after = ["network-online.target"];
      wants = ["network-online.target"];
    };

    # Update service
    systemd.services.notesSiteUpdate = {
      description = "Update Hugo notes site";
      serviceConfig = {
        Type = "oneshot";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${buildScript}";
        ExecStartPost = "systemctl reload nginx";
      };
      after = ["notesSiteBuild.service"];
    };

    # Timer for periodic updates
    systemd.timers.notesSiteUpdate = {
      description = "Timer to rebuild Hugo notes site periodically";
      wantedBy = ["timers.target"];
      timerConfig = {
        OnUnitActiveSec = cfg.updateInterval;
        Persistent = true;
      };
    };

    # Nginx configuration
    services.nginx = {
      enable = true;
      virtualHosts = {
        ${
          if cfg.domain != null
          then cfg.domain
          else "default"
        } = {
          listen = [
            {
              addr = "0.0.0.0";
              port = cfg.port;
            }
          ];
          root = cfg.outputDir;
          locations."/" = {
            tryFiles = "$uri $uri/ /index.html";
          };
        };
      };
    };

    # Packages
    environment.systemPackages = with pkgs; [git hugo];

    # Firewall example (for Tailscale)
    networking.firewall.interfaces."tailscale0".allowedTCPPorts = [cfg.port];
  };
}
