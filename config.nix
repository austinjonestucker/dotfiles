{
    packageOverrides = pkgs: with pkgs; {
       myPackages = pkgs.buildEnv {
          name = "austin-tools";
          paths = [
            neovim
            ripgrep
            fzf
            jq
            lazygit
            bash-completion
            nodejs_22
            neofetch
          ];
       };
    };
}
