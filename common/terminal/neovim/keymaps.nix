_: {
  programs.nixvim.keymaps = [
    {
      action = "<C-r>";
      key = "q";
      mode = "n";
      options.desc = "Easier redo.";
    }

    {
      action.__raw = "function() require('flash').jump() end";
      key = "<CR>";
      mode = "n";
      options.desc = "Jump with Flash";
    }

    # no arrow keys
    {
      action = "<cmd>echo 'Use h to move.'<CR>";
      key = "<left>";
      mode = "n";
    }
    {
      action = "<cmd>echo 'Use j to move.'<CR>";
      key = "<right>";
      mode = "n";
    }
    {
      action = "<cmd>echo 'Use k to move.'<CR>";
      key = "<up>";
      mode = "n";
    }
    {
      action = "<cmd>echo 'Use l to move.'<CR>";
      key = "<down>";
      mode = "n";
    }

    # easier pane movement
    {
      action = "<C-w><C-h>";
      key = "<C-h";
      mode = "n";
    }
    {
      action = "<C-w><C-j>";
      key = "<C-j";
      mode = "n";
    }
    {
      action = "<C-w><C-k>";
      key = "<C-k>";
      mode = "n";
    }
    {
      action = "<C-w><C-l>";
      key = "<C-l>";
      mode = "n";
    }

    # easier cmds
    {
      action = ":";
      key = ";";
      mode = "n";
    }

    {
      action = ":noh<CR>";
      key = "<Esc>";
      mode = "n";
      options = {
        silent = true;
        desc = "Clear search highlights.";
      };
    }

    {
      action.__raw = "function() Snacks.picker.buffers() end";
      key = "<leader>fb";
      mode = "n";
      options.desc = "Buffers";
    }
    {
      action.__raw = "function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end";
      key = "<leader>fc";
      mode = "n";
      options.desc = "Find Config File";
    }
    {
      action.__raw = "function() Snacks.picker.files() end";
      key = "<leader><leader>";
      mode = "n";
      options.desc = "Find Files";
    }
    {
      action.__raw = "function() Snacks.picker.git_files() end";
      key = "<leader>fg";
      mode = "n";
      options.desc = "Find Git Files";
    }
    {
      action.__raw = "function() Snacks.picker.projects() end";
      key = "<leader>fp";
      mode = "n";
      options.desc = "Projects";
    }
    {
      action.__raw = "function() Snacks.picker.recent() end";
      key = "<leader>fr";
      mode = "n";
      options.desc = "Recent";
    }
    {
      action.__raw = "function() Snacks.picker.gh_issue() end";
      key = "<leader>gi";
      mode = "n";
      options.desc = "GitHub Issues (open)";
    }
    {
      action.__raw = "function() Snacks.picker.gh_issue({ state = 'all' }) end";
      key = "<leader>gI";
      mode = "n";
      options.desc = "GitHub Issues (all)";
    }
    {
      action.__raw = "function() Snacks.picker.gh_pr() end";
      key = "<leader>gp";
      mode = "n";
      options.desc = "GitHub Pull Requests (open)";
    }
    {
      action.__raw = "function() Snacks.picker.gh_pr({ state = 'all' }) end";
      key = "<leader>gP";
      mode = "n";
      options.desc = "GitHub Pull Requests (all)";
    }
    {
      action.__raw = "function() Snacks.gitbrowse() end";
      key = "<leader>go";
      mode = "n";
      options.desc = "Open file on GitHub";
    }
    {
      action.__raw = "function() Snacks.picker.git_status() end";
      key = "<leader>gs";
      mode = "n";
      options.desc = "Git Status";
    }
    {
      action.__raw = "function() Snacks.picker.git_log() end";
      key = "<leader>gl";
      mode = "n";
      options.desc = "Git Log";
    }
    {
      action.__raw = "function() Snacks.picker.lines() end";
      key = "<leader>sb";
      mode = "n";
      options.desc = "Buffer Lines";
    }
    {
      action.__raw = "function() Snacks.picker.grep_buffers() end";
      key = "<leader>sB";
      mode = "n";
      options.desc = "Grep Open Buffers";
    }
    {
      action.__raw = "function() Snacks.picker.grep() end";
      key = "<leader>sg";
      mode = "n";
      options.desc = "Grep";
    }
    {
      action.__raw = "function() Snacks.picker.grep_word() end";
      key = "<leader>sw";
      mode = ["n" "x"];
      options.desc = "Visual selection or word";
    }
    {
      action.__raw = "function() Snacks.picker.undo() end";
      key = "<leader>su";
      mode = "n";
      options.desc = "Undo History";
    }
    {
      action.__raw = "function() Snacks.scratch() end";
      key = "<leader>.";
      mode = "n";
      options.desc = "Toggle Scratch Buffer";
    }
    {
      action.__raw = "function() Snacks.scratch.select() end";
      key = "<leader>S";
      mode = "n";
      options.desc = "Select Scratch Buffer";
    }
    {
      action.__raw = "function() Snacks.terminal() end";
      key = "<c-/>";
      mode = "n";
      options.desc = "Toggle Terminal";
    }
    {
      action.__raw = "function() Snacks.zen() end";
      key = "<leader>z";
      mode = "n";
      options.desc = "Toggle Zen Mode";
    }
    {
      action.__raw = "function() require('neo-tree.command').execute({ toggle = true, reveal = true, position = 'float' }) end";
      key = "<leader>e";
      mode = "n";
      options.desc = "Toggle Neo-tree (float)";
    }
  ];
}
