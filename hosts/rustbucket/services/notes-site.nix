{
  imports = [../modules/notes-site.nix];
  services.notesSite = {
    enable = true;
    repoUrl = "https://github.com/1blckhrt/public-notes.git";
    branch = "main";
    buildDir = "/var/lib/notes-site/repo";
    outputDir = "/var/lib/notes-site/public";
    user = "notes-site";
    group = "notes-site";
    domain = "100.123.22.19"; # Or Tailscale domain
    baseURL = null;
    siteTitle = "My Personal Notes";
    subtitle = "A collection of thoughts and learnings";
    notesDirectory = "notes";
    port = 80;
    updateInterval = "10m"; # Rebuild every 10 minutes
  };
}
