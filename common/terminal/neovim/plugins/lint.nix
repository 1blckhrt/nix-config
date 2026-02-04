_: {
  programs.nixvim = {
    plugins.lint = {
      enable = true;
      lintersByFt = {
        python = ["mypy"];
      };
      linters.mypy.args = [
        "--pretty"
      ];
    };

    autoCmd = [
      {
        event = ["BufWritePost" "BufEnter" "InsertLeave"];
        callback.__raw = ''
          function()
            require("lint").try_lint()
          end
        '';
      }
    ];
  };
}
