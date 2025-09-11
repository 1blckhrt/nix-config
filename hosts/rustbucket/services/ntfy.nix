{
  config,
  pkgs,
  ...
}: {
  services.ntfy-sh = {
    enable = true;
    settings = {
      listen-http = ":8080";
      upstream-base-url = "https://ntfy.sh";
      base-url = "http://100.123.22.19:8080";
    };
  };
}
