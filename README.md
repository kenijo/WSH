# WSH

WSH is a packaged installer that will allow you to create a fully customized shell environment through a simple
installer.
It takes the hard work out of downloading and configuring all the components you need.

WSH simplifies the installation by asking simple questions and taking care of downloading and installing everything for you from trusted sources (official repositories).
It has a modular architecture that allows anyone to add and improve the installer easily.

## Repository

The repository contains the code to generate the simple installer based on [Inno
Setup](https://jrsoftware.org/isinfo.php) scripts.

The releases are the compiled version of WSH.

## Packages

- [Clink](https://chrisant996.github.io/clink) ([Github](https://github.com/chrisant996/clink))
- [Git](https://git-scm.com) ([Github](https://github.com/git-for-windows/git))
- [PHP](http://php.net)
- [PuTTY](http://www.putty.org)
- [Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701) ([Github](https://github.com/microsoft/terminal))

### Fonts

- [Cascadia Code - Variable Font](https://github.com/microsoft/cascadia-code)
- [Cascadia Mono - Variable Font](https://github.com/microsoft/cascadia-code)
- [Fira Code - Variable Font](https://github.com/tonsky/FiraCode)
- [Hack](https://github.com/source-foundry/Hack)
- [Hasklig](https://github.com/i-tu/Hasklig)
- [JerBrains Mono - Variable Font](https://www.jetbrains.com/lp/mono/)
- [Noto Sans Mono - Variable Font](https://notofonts.github.io/)
- [RedHat Mono - Variable Font](https://github.com/RedHatOfficial/RedHatFont)
- [Roboto Mono - Variable Font](https://fonts.google.com/specimen/Roboto+Mono)
- [SF Mono Nerd-Font-Ligaturized](https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized)
- [SF Mono](https://github.com/blaisck/sfwin)
- [Source Code Pro - Variable Font](https://github.com/adobe-fonts/source-code-pro)
- [Ubuntu Mono - Variable Font](https://design.ubuntu.com/font/)
- [Victor Mono](https://rubjo.github.io/victor-mono/)

- Additional [Programming Fonts](https://www.programmingfonts.org/)
- List of [Monospaced Fonts](https://en.m.wikipedia.org/wiki/List_of_monospaced_typefaces)
- Too overwhelmed? Find your font in this [Coding Font Tournament](https://www.codingfont.com/)

### Vim

- [Plugin LightLine](https://github.com/itchyny/lightline.vim) A light and configurable statusline/tabline plugin for Vim.
- [Plugin Polyglot](https://github.com/sheerun/vim-polyglot) A collection of language packs for Vim.
- [Theme Monokai Pro](https://github.com/phanviet/vim-monokai-pro)
- [Theme Nord](https://github.com/nordtheme/vim)
- [Vim Plug](https://github.com/junegunn/vim-plug) A minimalist Vim plugin manager.

## How to compile your own version of WSH

  1. Download and install [Inno setup](https://jrsoftware.org/isdl.php). Currently tested with NSIS 6.x
  2. Edit the script in the `build` folder.
  3. Compile the `.\build\wsh.iss` script and you'll get a `.build\WSH.exe` installer

## License

MIT

[//]: < @author      Kenrick JORUS >
[//]: < @copyright   2022 Kenrick JORUS >
[//]: < @license     MIT License >
[//]: < @link        http://kenijo.github.io/WSH/ >
