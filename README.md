# WSH
WSH is a packaged installer that will allow you to create a fully customized shell environment through a single simple installer.
It takes the hard work out of downloading and configuring all the components you need.
WSH simplifies the installation by asking simple questions and taking care of downloading and installing everything for you from trusted sources (official repositories).
It has a modular architecture that allows anyone to add and improve the installer easily.

---

# Repository
The repository contains the code to to generate the simple installer based on [Inno Setup](https://jrsoftware.org/isinfo.php) scripts.
The releases are the compiled version of WSH.

---

# Packages
  - [Clink](https://chrisant996.github.io/clink) ([repo](https://github.com/chrisant996/clink))
  - [Free Programing Fonts](http://cdn.sixrevisions.com/0441-01_programming-fonts/demo/programming-fonts.html)
  - [Git](https://git-scm.com) ([repo](https://github.com/git-for-windows/git))
  - [KiTTY](http://kitty.9bis.net)
  - [PHP](http://php.net)
  - [PuTTY](http://www.putty.org)
  - [Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701) ([repo](https://github.com/microsoft/terminal))

---

# How to compile your own version of Shrak
  1. Download and install [Inno setup](https://jrsoftware.org/isdl.php). Currently tested with NSIS 6.2.1
  2. Edit the script in the `build` folder.
  3. Compile the `.\build\wsh.iss` script and you'll get a `.build\WSH.exe` installer

---

# License
MIT

[//]: < @author      Kenrick JORUS >
[//]: < @copyright   2022 Kenrick JORUS >
[//]: < @license     MIT License >
[//]: < @link        http://kenijo.github.io/WSH/ >