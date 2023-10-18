{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      vim-fugitive
      leap-nvim
    ];
    extraLuaConfig = ''
      do
        local o = vim.opt
        o.nu = true
        o.rnu = true

        o.autoindent = true
        o.smartindent = true

        o.shiftwidth = 4
        o.tabstop = 4
        o.expandtab = true
        local indents = {
          ["haskell"] = 2,
          ["nix"] = 2,
          ["lua"] = 4,
          ["c"] = 8,
        }
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "*",
          callback = function() 
            local ft = vim.bo.filetype
            print(ft)
            o.shiftwidth = indents[ft] or 4
            o.tabstop = indents[ft] or 4
          end
        })
      end
      do --plugins
        --TODO: nothing yet lmao
      end
    '';
  };
}
