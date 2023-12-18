# this is here a a placeholder example for loading certain packages from the unstable channel

{ config, pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import <unstable> { config = baseconfig; };
in {
  environment.systemPackages = with pkgs; [
    # moved these to home-manager
    # unstable.cryptomator
    # unstable.newsflash
  ];
}

