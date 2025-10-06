_: {
  programs.nixvim.opts = {
    number = true;
    relativenumber = true;
    termguicolors = true;

    smartindent = true;
    autoindent = true;
    softtabstop = 2;
    shiftwidth = 2;
    tabstop = 2;

    swapfile = false;
    backup = false;
    undofile = true;

    hlsearch = false;
    incsearch = true;

    autoread = true;
    wrap = true;
    linebreak = true;
    cursorline = true;
  };
}
