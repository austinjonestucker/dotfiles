{
    packageOverrides = pkgs: with pkgs; {
       myPackages = pkgs.buildEnv {
          name = "austin-tools";
          path = [
            neovim
            ripgrep
            fzf
            jq
            bash-completion
            nodejs_22
            neofetch
          ];
       };
    };
}
