{
  config,
  pkgs,
  nixgl,
  ...
}: {
  imports = [./neovim];
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
  ];
  nixGL.packages = nixgl.packages;

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.ubuntu-mono
    du-dust
    jq
    ripgrep
    unzip
    trash-cli
    lazygit
    htop
    nodejs_20
    gcc
    openssl
    pkg-config
  ];

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    exitShellOnExit = true;

    settings = {
      default_shell = "${pkgs.zsh}/bin/zsh";
      pane_frames = false;
      show_startup_tips = false;
      # copy_command = "xclip -selection clipboard";
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.share = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };
    shellAliases = {
      "ll" = "ls -l";
      "la" = "ls -la";
      ".." = "cd ..";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.alacritty = {
    enable = true;
    package = config.lib.nixGL.wrappers.mesa pkgs.alacritty;
    settings = {
      terminal.shell = "${pkgs.zellij}/bin/zellij";
      colors.primary = {
        foreground = "#FFFFFF";
        background = "#000000";
      };
      window = {
        decorations = "None";
        startup_mode = "Fullscreen";
      };
      font.normal = {
        family = "UbuntuMono Nerd Font";
        style = "Regular";
      };
      font.size = 19;
      keyboard.bindings = [
        {
          key = "F11";
          action = "ToggleFullscreen";
        }
        {
          key = "F10";
          action = "ToggleViMode";
        }
        {
          key = "Backspace";
          mods = "Control";
          chars = "\\u0017";
        }
      ];
    };
  };
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."github.com" = {
      user = "git";
      hostname = "ssh.github.com";
      identityFile = "${config.home.homeDirectory}/.ssh/id_rsa";
      port = 443;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    FS3_COMPILER_IMAGE = "nexus.ic-cyber.lab/repository/docker-hosted/fs3compiler-rustc-1.91-v0.1:latest";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
