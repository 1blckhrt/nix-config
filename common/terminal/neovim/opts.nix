_: {
  programs.nixvim.opts = {
    undofile = true;
    smartindent = true;
    termguicolors = true;
    background = "dark";
    wrap = true;
    cursorline = true;
    relativenumber = true;
    number = true;
    ignorecase = true;
    smartcase = true;
    splitright = true;
    splitbelow = true;
    scrolloff = 10;
    confirm = true;
    mouse = "a";
    showmode = false;
    updatetime = 250;
    timeoutlen = 300;
    softtabstop = 2;
    shiftwidth = 2;
    tabstop = 2;
    modelineexpr = true;
    modelines = 4;
    modeline = true;
    linebreak = true;
    autoread = true;
    hlsearch = false;
    swapfile = false;
    incsearch = true;
    winborder = "rounded";
  };
}
