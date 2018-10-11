{
  pkgs,
  custpkgs,
  envs,
}:
with pkgs // custpkgs;
rec {
  nixos = builtins.pathExists /etc/nixos/configuration.nix;
  optionals = lib.optionals;


  # Basic packages.
  cli-base = [
    bashInteractive
    bash-completion
    direnv
    file
    git-lfs
    gitFull
    gitAndTools.gitflow
    gnupg
    man
    time
    tmux
    vimHugeX
    xdg-user-dirs
    zsh
    zsh-completions
  ];


  # Basic GUI packages.
  gui-base = [
    blueman
    dmenu
    dunst
    gnome3.adwaita-icon-theme
    gnome3.nautilus
    gnome3.networkmanagerapplet
    gnome3.seahorse
    gnome3.zenity
    i3pystatus
    ibus
    ibus-engines.anthy
    ibus-engines.table
    ibus-engines.table-others
    keybase-gui
    libnotify
    numlockx
    pamixer
    pavucontrol
    pngcrush
    redshift
    scrot
    st
    system-config-printer
    unclutter-xfixes
    x11_ssh_askpass
    xclip
    xcompmgr
    xorg.xdpyinfo
    xorg.xkill
    xorg.xmodmap
    xss-lock
  ] ++ optionals (nixos) [
    gksu
    i3
    i3lock
    lightdm
    lightdm_gtk_greeter
  ] ++ gui-fonts;


  # GUI fonts.
  gui-fonts = [
    corefonts
    dejavu_fonts
    font-droid
    ipafont
    league-of-moveable-type
    liberation_ttf
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    powerline-fonts
  ];


  # Media.
  cli-media = [
    mpc_cli
    mpd
    mpv
    ncmpcpp
    playerctl
    sox
    youtube-dl
  ];


  # GUI media.
  gui-media = [
    appimage-run
    chromium
    discord
    evince
    gimp
    gnome3.eog
    inkscape
    kdeconnect
    mcomix
    picard
    skypeforlinux
    slack
    spotify
    thunderbird
  ];


  # Games.
  cli-games = [
    cataclysm-dda-git
    nethack
    steam
    steam-run
  ] ++ optionals (nixos) [
    scanmem
  ];


  # GUI Games.
  gui-games = [
    cabextract
    ftb
    jre
    playonlinux
    wineStaging
    winetricks
  ];


  # Development tools.
  cli-devel = [
    ack
    ag
    bumpversion
    cloc
    cookiecutter
    ctags
    graphviz
    strace
  ] ++ optionals (nixos) [
    linuxPackages.systemtap
  ];


  # Nice utilities.
  cli-utilities = [
    agrep
    bc
    bzip2
    coreutils
    curl
    ddrescue
    diceware
    dos2unix
    dosfstools
    dot2tex
    ffmpeg
    gnutar
    gptfdisk
    gzip
    htop
    iotop
    jq
    libisoburn
    lm_sensors
    manpages
    nix-repl
    nox
    openssh
    pandoc
    pass
    pinfo
    posix_man_pages
    psmisc
    pv
    pwgen
    pydf
    python36Packages.glances
    squashfsTools
    texlive.combined.scheme-full
    tree
    ttyrec
    unrar
    unzip
    wget
    xar
    xz
  ] ++ optionals (nixos) [
    acct
    docker
    lsof
    mlocate
    zfs
  ];


  # Nice GUI utilities.
  gui-utilities = [
    #baobab
    gnome3.gnome-disk-utility
    #libreoffice-fresh
    virtmanager
    xdotool
  ];


  # Networking.
  cli-netutilities = [
    aria2
    avahi
    dnsutils
    host
    nxBender
  ] ++ optionals (nixos) [
    chrony
    links
    megatools
    mosh
    mtr
    ngrep
    nmap
    socat
    sshfs
    telnet
    tmate
    tor
    torsocks
  ];

  gui-netutilities = [
    tor-browser-bundle
  ] ++ optionals (nixos) [
    wireshark
  ];


  # Interpreters.
  cli-languages = [
    R
    #androidndk
    #androidsdk_extras
    #cabal-install
    #cabal2nix
    gnuplot
    #go
    #mono
    octave
    perl
    perlPackages.Appcpanminus
    ruby
    #rustc
    python2
    python3
  ];


  # Development environments.
  dev-envs = with envs.devel; [
    cpp
  ];


  # All CLI packages.
  cli-full =
    cli-base
    ++ dev-envs
    ++ cli-devel
    ++ cli-games
    ++ cli-languages
    ++ cli-media
    ++ cli-netutilities
    ++ cli-utilities;


  # All GUI packages.
  gui-full =
    cli-full
    ++ gui-base
    ++ gui-games
    ++ gui-media
    ++ gui-netutilities
    ++ gui-utilities;
}