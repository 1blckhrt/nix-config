{pkgs, ...}: let
  nord-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "nord-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "gbprod";
      repo = "nord.nvim";
      rev = "07647ad23e5b7fc1599a841dcd8f173b9aeb0419";
      hash = "sha256-+nZb7P2z4S26amtguGAvAevf60Dn/uniSVZvR0DM+zw=";
    };
  };
in {
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    waylandSupport = true;

    extraPlugins = [
      nord-nvim
    ];

    extraConfigLua = ''
       require("nord").setup({
         transparent = true,
         terminal_colors = true,
         diff = { mode = "bg" },
         borders = true,
         styles = {
           comments = { italic = false },
           keywords = { bold = true },
      lualine_bold = true,
         },
       })

       vim.cmd.colorscheme('nord')
    '';
  };
  imports = [./clipboard.nix ./globals.nix ./keymaps.nix ./opts.nix ./plugins/default.nix];
}
