{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "brent";
  home.homeDirectory = "/home/brent";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # gui apps
    pkgs.alacritty
    pkgs.cryptomator
    pkgs.insomnia
    pkgs.obsidian

    # browsers
    pkgs.brave
    pkgs.librewolf

    # lunarvim related
    pkgs.lunarvim
    pkgs.xclip
    pkgs.ripgrep

    # tmux related
    pkgs.tmuxinator

    # other webdev
    pkgs.jq
    pkgs.lazygit
    pkgs.fishPlugins.tide
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/brent/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "lvim";
    # STARSHIP_CONFIG = "$HOME/.config/starship/starship.toml";
  };

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.yarn/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.command-not-found.enable = true;

  programs.fish = {
    enable = true;

    shellInit = ''
      fish_vi_key_bindings

      function fish_mode_prompt
      end

      set -U fish_greeting
    '';

    shellAliases = {
      cls = "clear";
      vi = "lvim";
      sshcolor = "TERM=xterm-256color ssh";
      cleandocker = "sudo docker rmi $(sudo docker images --filter \"dangling=true\" -q --no-trunc)";
      mongoconnect = "sudo docker exec -it mongotest mongosh";
      mux = "tmuxinator";
    };

    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
        # tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Few icons' --transient=No
        # removed context/hostname from right: set --universal -e tide_right_prompt_items[3]
        # adds context/hostname to left: set --universal tide_left_prompt_items context $tide_left_prompt_items
      }
    ];
  };

  programs.tmux = {
    enable = true;
    /* switched to using tpm for plugins
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.catppuccin
      * this didnt work because tokuo doesnt have an archive release - leaving here for reference *
      {
        plugin = tmuxPlugins.mkTmuxPlugin {
          pluginName = "tmux-tokyo-night";
          version = "a98dc1e";
          src = pkgs.fetchFromGitHub {
            owner = "janoamaral";
            repo = "tokyo-night-tmux";
            rev = "a98dc1ea64df0d945957362e177a15a4a695de3c";
            # sha256 = "sha256-PWLl8h6bczLtcNL0cFwaCbq1K/0O3eR0/Z/5wbUuN+Y=";
          };
        };
      }
    ];
    */
    extraConfig = ''
      # enable mouse support
      set -g mouse on

      # move the status bar to the top
      set-option -g status-position top

      # change tmux prefix key
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      # set pane numbers to start at 1
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # bindings to navigate windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # ensure new panes start in the cwd of the pane split from
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # theme term settings are to ensure that all the themes/colors/features work in neovim
      set-option -g default-terminal "screen-256color"

      # set the default TERM
      if-shell 'infocmp $TERM' { set default-terminal "$TERM" } { set default-terminal tmux-256color }

      # Enable RGB (truecolor)
      set -a terminal-features '*:RGB'

      # Enable colored underlines (e.g. in Vim)
      set -a terminal-features '*:usstyle'

      set -ga terminal-overrides ",alacritty:RGB"
      set -ga terminal-overrides ",*256col*:Tc"

      # fix the cursor shape https://github.com/neovim/neovim/issues/5096#issuecomment-469027417
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      # undercurl support
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      # underscore colours - needs tmux-3.0
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      # Use extended keys (CSI u)
      set -g extended-keys on

      ## update the TERM variable of terminal emulator when creating a new session or attaching a existing session
      set -g update-environment 'DISPLAY SSH_ASKPASS SSH_AGENT_PID SSH_CONNECTION WINDOWID XAUTHORITY TERM'

      # tpm plugins - see https://github.com/tmux-plugins/tpm
      # don't forget to use <prefix>I to install newly added plugins
      # set -g @catppuccin_flavour 'mocha' 

      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-yank'
      set -g @plugin 'christoomey/vim-tmux-navigator'
      set -g @plugin 'catppuccin/tmux'

      # Other examples:
      # set -g @plugin 'github_username/plugin_name'
      # set -g @plugin 'github_username/plugin_name#branch'
      # set -g @plugin 'git@github.com:user/plugin'
      # set -g @plugin 'git@bitbucket.com:user/plugin'

      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run '~/.tmux/plugins/tpm/tpm'
    '';
  };

  /*
  programs.bash = {
    enable = true;

    shellAliases = {
      cls = "clear";
      vi = "lvim";
      kopialogs = "journalctl -u kopia-backup.service";
      cleandocker="sudo docker rmi $(sudo docker images --filter \"dangling=true\" -q --no-trunc)";
      runsshagent="eval \"$(ssh-agent -s)\"";
      screenshot="nix-shell -p ksnip --run \"ksnip -r\"";
      mongoconnect="sudo docker exec -it mongotest mongosh";
    };
  };
  */

	/*
  programs.neovim = {
    enable = true;
    plugins = [
      # pkgs.vimPlugins.lazy-nvim
      pkgs.vimPlugins.tokyonight-nvim
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.which-key-nvim
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.dashboard-nvim
      pkgs.vimPlugins.nvim-tree-lua
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.trouble-nvim
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.astro
        p.bash
        p.css
        p.dockerfile
        p.gitignore
        p.go
        p.html
        p.javascript
        p.jq
        p.jsdoc
        p.json
        p.lua
        p.nix
        p.php
        p.prisma
        p.python
        p.regex
        p.rust
        p.scss
        p.sql
        p.svelte
        p.tsx
        p.twig
        p.typescript
        p.vue
        p.yaml
      ]))
      # mason-related
      pkgs.vimPlugins.mason-nvim
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.mason-lspconfig-nvim
      pkgs.vimPlugins.nvim-dap
      pkgs.vimPlugins.nvim-dap-ui
      pkgs.vimPlugins.null-ls-nvim
      pkgs.vimPlugins.nvim-lint
      pkgs.vimPlugins.formatter-nvim
    ];
  };
	*/
}
