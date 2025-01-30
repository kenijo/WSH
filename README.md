# WSH

WSH is a packaged installer that will allow you to create a fully customized shell environment through a simple installer.
It takes the hard work out of downloading and configuring all the components you need.

WSH simplifies the installation by asking simple questions and taking care of downloading and installing everything for you from trusted sources (official repositories).
It has a modular architecture that allows anyone to add and improve the installer easily.

## Repository

The repository contains the code to generate the simple installer based on [InnoSetup](https://jrsoftware.org/isinfo.php) scripts.

The releases are the compiled version of WSH.

## Packages

- [Clink](https://chrisant996.github.io/clink) ([Github](https://github.com/chrisant996/clink)) Bash's powerful command line editing
- [Git](https://git-scm.com) ([Github](https://github.com/git-for-windows/git)) Distributed version control system
- [PHP](http://php.net) General-purpose scripting language geared towards web development
- [PuTTY](http://www.putty.org) Terminal emulator, serial console nad network file transfer application
- [Vim Plugin LightLine](https://github.com/itchyny/lightline.vim) Light and configurable statusline/tabline plugin for Vim.

## Recommanded Fonts

- [Cascadia Code](https://github.com/microsoft/cascadia-code)
- [Cascadia Mono](https://github.com/microsoft/cascadia-code)
- [Fira Code](https://github.com/tonsky/FiraCode)
- [Hack](https://github.com/source-foundry/Hack)
- [JetBrains Mono](https://www.jetbrains.com/lp/mono)
- [Noto Sans Mono](https://notofonts.github.io/)
- [RedHat Mono](https://github.com/RedHatOfficial/RedHatFont)
- [Roboto Mono](https://fonts.google.com/specimen/Roboto+Mono)
- [SF Mono Nerd-Font-Ligaturized](https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized)
- [SF Mono](https://github.com/blaisck/sfwin)
- [Source Code Pro](https://github.com/adobe-fonts/source-code-pro)
- [Source Code Pro Ligaturized](https://github.com/kenijo/Ligaturizer)
- [Ubuntu Mono](https://design.ubuntu.com/font)
- [Victor Mono](https://rubjo.github.io/victor-mono)

- List of [Monospaced Fonts](https://en.m.wikipedia.org/wiki/List_of_monospaced_typefaces) (With and without ligature)
- List of [Nerd Fonts](https://www.nerdfonts.com) (Patched with glyphs)
- Test some [Programming Fonts](https://www.programmingfonts.org)
- Too overwhelmed? Find your font in this [Coding Font Tournament](https://www.codingfont.com)

## Vim Themes (ported to CMD, MobaXterm, PuTTY, Windows Terminal)

- [Monokai Pro for Vim](https://github.com/phanviet/vim-monokai-pro)
- [Nord for Vim](https://github.com/nordtheme/vim)
- [OneDark Pro for Vim](https://github.com/joshdick/onedark.vim)

## How to compile your own version of WSH

  1. Download and install [Inno setup](https://jrsoftware.org/isdl.php). Currently tested with NSIS 6.x
  2. Edit the script in the `build` folder.
  3. Compile the `.\build\wsh.iss` script and you'll get a `.build\WSH.exe` installer

## License

MIT

[//]: < @link        http://kenijo.github.io/WSH/ >
[//]: < @license     MIT License >
