{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [ zsh-fzf-history-search ];
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
    };

    history = {
      save = 10000;
      size = 10000;
      path = "$HOME/.cache/zsh_history";
    };

    initExtra = ''
      eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.toml)"

      bindkey '^[[1;5C' forward-word # Ctrl+RightArrow
      bindkey '^[[1;5D' backward-word # Ctrl+LeftArrow
      bindkey '^ ' autosuggest-accept # Ctrl+Space

      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*:match:*' original only
      zstyle ':completion:*:approximate:*' max-errors 1 numeric
      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

      eval "$(zoxide init --cmd cd zsh)"

      # This command let's me execute arbitrary binaries downloaded through channels such as mason.
      export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')

      export EDITOR=nvim
    '';

    shellAliases = {
      ls = "eza -gl --git --color=automatic";
      tree = "eza --tree";
      cat = "bat";

      ip = "ip --color";
      ipb = "ip --color --brief";

      gac = "git add -A  && git commit -a";
      gp = "git push";
      gst = "git status -sb";

      neofetch = "fastfetch";

      tf = "terraform";
      tfi = "terraform init";
      tfp = "terraform plan";
      tfa = "terraform apply -auto-approve";
      tfd = "terraform destroy -auto-approve";
      tfo = "terraform output -json";

      open = "xdg-open";

      speedtest = "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";

      cleanup-nix = "nh clean all --keep-since 10d --keep 3";
      rln = "nh os switch";
      rlh = "nh home switch";
    };
  };
}
