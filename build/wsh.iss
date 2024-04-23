//-----------------------------------------------------------------------------
// @author       Kenrick JORUS
// @copyright    2022 Kenrick JORUS
// @license      MIT License
// @link         http://kenijo.github.io/WSH/
// @description  Inno Setup script for WSH
//-----------------------------------------------------------------------------

[Setup]
AppName=WSH
AppVerName=WSH
WizardStyle=modern
WizardSizePercent=130
DefaultDirName={commonpf}\WSH
DefaultGroupName=WSH
SetupIconFile=..\icons\wsh.ico
OutputBaseFilename=WSH
OutputDir=.
AllowCancelDuringInstall=no
// Specifies that Setup cannot run on anything but x64
ArchitecturesAllowed=x64

[Types]
Name: "full";                     Description: "Full Installation";
Name: "custom";                   Description: "Custom Installation";   Flags: iscustom;

[Components]
Name: "clink";                    Description: "Clink";         Types: custom full;   Flags: fixed;
Name: "fonts";                    Description: "Fonts";         Types: full;
Name: "git";                      Description: "Git";           Types: full;
Name: "php";                      Description: "PHP";           Types: full;
Name: "putty";                    Description: "PuTTY";   Types: full;

[Tasks]
Name: cmd_context_menu;           Description: "Add ""Open CMD""";                  GroupDescription: "Context Menu (Right Click):";
Name: ubuntu_context_menu;        Description: "Add ""Open Ubuntu""";               GroupDescription: "Context Menu (Right Click):";
Name: powershell_context_menu;    Description: "Add ""Open PowerShell""";           GroupDescription: "Context Menu (Right Click):";

Name: cmd_theme;                  Description: "Apply CMD Nord Theme";              GroupDescription: "Themes:";
;Name: kitty_theme;                Description: "Apply KiTTY Nord Theme";            GroupDescription: "Themes:";                        Components: putty;
Name: putty_theme;                Description: "Apply PuTTY Nord Theme";            GroupDescription: "Themes:";                        Components: putty;

Name: cmd_settings;               Description: "Apply CMD Settings";                GroupDescription: "Settings:";
;Name: kitty_settings;             Description: "Apply KiTTY Settings";              GroupDescription: "Settings:";                      Components: putty;
Name: putty_settings;             Description: "Apply PuTTY Settings";              GroupDescription: "Settings:";                      Components: putty;
Name: wterm_settings;             Description: "Apply Windows Terminal Settings";   GroupDescription: "Settings:";

[Files]
// Install local files
Source: "..\build\*";                                                         DestDir: "{app}\build";                                                                           Flags: recursesubdirs restartreplace uninsrestartdelete;    Excludes: "{OutputBaseFilename}";
Source: "..\config\bash\*";                                                   DestDir: "{app}\config\bash";                                                                     Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\config\bash\*";                                                   DestDir: "\\wsl$\Ubuntu\home\{code:AnsiLowercase|{username}}";                                    Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\config\clink\*";                                                  DestDir: "{app}\config\clink";                                          Components: clink;        Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\config\cmd\*";                                                    DestDir: "{app}\config\cmd";                                                                      Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\config\git\*";                                                    DestDir: "{app}\config\git";                                            Components: git;          Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\config\putty\*";                                                  DestDir: "{app}\config\putty";                                          Components: putty;        Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\config\winterm\*";                                                DestDir: "{app}\config\winterm";                                                                  Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\config\winterm\*";                                                DestDir: "{commonappdata}\Microsoft\Windows Terminal\Fragments\WSH";    Tasks: wterm_settings;    Flags: recursesubdirs restartreplace uninsrestartdelete;    Check: IsAdminInstallMode
Source: "..\config\winterm\*";                                                DestDir: "{localappdata}\Microsoft\Windows Terminal\Fragments\WSH";     Tasks: wterm_settings;    Flags: recursesubdirs restartreplace uninsrestartdelete;    Check: not IsAdminInstallMode
Source: "{localappdata}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json";   DestDir: "{localappdata}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState";    DestName: "settings.wsh_backup.json";       Tasks: wterm_settings;    Flags: external ignoreversion restartreplace skipifsourcedoesntexist uninsneveruninstall uninsrestartdelete;
Source: "..\config\winterm\settings.json";                                                            DestDir: "{localappdata}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState";    DestName: "settings.json";                  Tasks: wterm_settings;    Flags: ignoreversion restartreplace uninsrestartdelete;
Source: "..\icons\*";                                                         DestDir: "{app}\icons";                                                                           Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\modules\bin\*";                                                   DestDir: "{app}\modules\bin";                                                                     Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\modules\clink\*";                                                 DestDir: "{app}\modules\clink";                                         Components: clink;        Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\modules\fonts\*";                                                 DestDir: "{app}\modules\fonts";                                         Components: fonts;        Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\modules\git\*";                                                   DestDir: "{app}\modules\git";                                           Components: git;          Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\modules\putty\*";                                                 DestDir: "{app}\modules\putty";                                         Components: putty;        Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\modules\php\*";                                                   DestDir: "{app}\modules\php";                                           Components: php;          Flags: recursesubdirs restartreplace uninsrestartdelete;

// Install fonts
Source: "..\modules\fonts\3DS\3ds Bold Italic.otf";                           DestDir: "{autofonts}"; FontInstall: "3ds";                             Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\3DS\3ds Bold.otf";                                  DestDir: "{autofonts}"; FontInstall: "3ds";                             Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\3DS\3ds Condensed Bold.otf";                        DestDir: "{autofonts}"; FontInstall: "3ds Condensed";                   Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\3DS\3ds Condensed Light.otf";                       DestDir: "{autofonts}"; FontInstall: "3ds Condensed Light";             Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\3DS\3ds Condensed Regular.otf";                     DestDir: "{autofonts}"; FontInstall: "3ds Condensed";                   Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\3DS\3ds ExtraLight Italic.otf";                     DestDir: "{autofonts}"; FontInstall: "3ds ExtraLight";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\3DS\3ds ExtraLight.otf";                            DestDir: "{autofonts}"; FontInstall: "3ds ExtraLight";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\3DS\3ds Italic.otf";                                DestDir: "{autofonts}"; FontInstall: "3ds";                             Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\3DS\3ds Light.otf";                                 DestDir: "{autofonts}"; FontInstall: "3ds Light";                       Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\3DS\3ds Regular.otf";                               DestDir: "{autofonts}"; FontInstall: "3ds";                             Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\3DS\3ds SemiBold Italic.otf";                       DestDir: "{autofonts}"; FontInstall: "3ds SemiBold";                    Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\3DS\3ds SemiBold.otf";                              DestDir: "{autofonts}"; FontInstall: "3ds SemiBold";                    Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto\Roboto-Black.ttf";                           DestDir: "{autofonts}"; FontInstall: "Roboto Black";                    Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto\Roboto-BlackItalic.ttf";                     DestDir: "{autofonts}"; FontInstall: "Roboto Black";                    Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto\Roboto-Bold.ttf";                            DestDir: "{autofonts}"; FontInstall: "Roboto";                          Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto\Roboto-BoldItalic.ttf";                      DestDir: "{autofonts}"; FontInstall: "Roboto";                          Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto\Roboto-Italic.ttf";                          DestDir: "{autofonts}"; FontInstall: "Roboto";                          Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto\Roboto-Light.ttf";                           DestDir: "{autofonts}"; FontInstall: "Roboto Light";                    Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto\Roboto-LightItalic.ttf";                     DestDir: "{autofonts}"; FontInstall: "Roboto Light";                    Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto\Roboto-Medium.ttf";                          DestDir: "{autofonts}"; FontInstall: "Roboto Medium";                   Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto\Roboto-MediumItalic.ttf";                    DestDir: "{autofonts}"; FontInstall: "Roboto Medium";                   Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto\Roboto-Regular.ttf";                         DestDir: "{autofonts}"; FontInstall: "Roboto";                          Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto\Roboto-Thin.ttf";                            DestDir: "{autofonts}"; FontInstall: "Roboto Thin";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto\Roboto-ThinItalic.ttf";                      DestDir: "{autofonts}"; FontInstall: "Roboto Thin";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-Bold.ttf";                   DestDir: "{autofonts}"; FontInstall: "Roboto Mono";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-BoldItalic.ttf";             DestDir: "{autofonts}"; FontInstall: "Roboto Mono";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-ExtraLight.ttf";             DestDir: "{autofonts}"; FontInstall: "Roboto Mono ExtraLight";          Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-ExtraLightItalic.ttf";       DestDir: "{autofonts}"; FontInstall: "Roboto Mono ExtraLight";          Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-Italic.ttf";                 DestDir: "{autofonts}"; FontInstall: "Roboto Mono";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-Light.ttf";                  DestDir: "{autofonts}"; FontInstall: "Roboto Mono Light";               Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-LightItalic.ttf";            DestDir: "{autofonts}"; FontInstall: "Roboto Mono Light";               Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-Medium.ttf";                 DestDir: "{autofonts}"; FontInstall: "Roboto Mono Medium";              Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-MediumItalic.ttf";           DestDir: "{autofonts}"; FontInstall: "Roboto Mono Medium";              Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-Regular.ttf";                DestDir: "{autofonts}"; FontInstall: "Roboto Mono";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-SemiBold.ttf";               DestDir: "{autofonts}"; FontInstall: "Roboto Mono SemiBold";            Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-SemiBoldItalic.ttf";         DestDir: "{autofonts}"; FontInstall: "Roboto Mono SemiBold";            Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-Thin.ttf";                   DestDir: "{autofonts}"; FontInstall: "Roboto Mono Thin";                Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Roboto Mono\RobotoMono-ThinItalic.ttf";             DestDir: "{autofonts}"; FontInstall: "Roboto Mono Thin";                Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Mono\SFMono-Bold.otf";                           DestDir: "{autofonts}"; FontInstall: "SF Mono";                         Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Mono\SFMono-BoldItalic.otf";                     DestDir: "{autofonts}"; FontInstall: "SF Mono";                         Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Mono\SFMono-Heavy.otf";                          DestDir: "{autofonts}"; FontInstall: "SF Mono";                         Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Mono\SFMono-HeavyItalic.otf";                    DestDir: "{autofonts}"; FontInstall: "SF Mono";                         Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Mono\SFMono-Light.otf";                          DestDir: "{autofonts}"; FontInstall: "SF Mono";                         Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Mono\SFMono-LightItalic.otf";                    DestDir: "{autofonts}"; FontInstall: "SF Mono";                         Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Mono\SFMono-Medium.otf";                         DestDir: "{autofonts}"; FontInstall: "SF Mono";                         Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Mono\SFMono-MediumItalic.otf";                   DestDir: "{autofonts}"; FontInstall: "SF Mono";                         Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Mono\SFMono-Regular.otf";                        DestDir: "{autofonts}"; FontInstall: "SF Mono";                         Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Mono\SFMono-RegularItalic.otf";                  DestDir: "{autofonts}"; FontInstall: "SF Mono";                         Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Mono\SFMono-Semibold.otf";                       DestDir: "{autofonts}"; FontInstall: "SF Mono";                         Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Mono\SFMono-SemiboldItalic.otf";                 DestDir: "{autofonts}"; FontInstall: "SF Mono";                         Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-Black.otf";                   DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-BlackItalic.otf";             DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-Bold.otf";                    DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-BoldItalic.otf";              DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-Heavy.otf";                   DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-HeavyItalic.otf";             DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-Light.otf";                   DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-LightItalic.otf";             DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-Medium.otf";                  DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-MediumItalic.otf";            DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-Regular.otf";                 DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-RegularItalic.otf";           DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-Semibold.otf";                DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-SemiboldItalic.otf";          DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-Thin.otf";                    DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-ThinItalic.otf";              DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-Ultralight.otf";              DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Display-UltralightItalic.otf";        DestDir: "{autofonts}"; FontInstall: "SF Pro Display";                  Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Text-Bold.otf";                       DestDir: "{autofonts}"; FontInstall: "SF Pro Text";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Text-BoldItalic.otf";                 DestDir: "{autofonts}"; FontInstall: "SF Pro Text";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Text-Heavy.otf";                      DestDir: "{autofonts}"; FontInstall: "SF Pro Text";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Text-HeavyItalic.otf";                DestDir: "{autofonts}"; FontInstall: "SF Pro Text";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Text-Light.otf";                      DestDir: "{autofonts}"; FontInstall: "SF Pro Text";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Text-LightItalic.otf";                DestDir: "{autofonts}"; FontInstall: "SF Pro Text";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Text-Medium.otf";                     DestDir: "{autofonts}"; FontInstall: "SF Pro Text";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Text-MediumItalic.otf";               DestDir: "{autofonts}"; FontInstall: "SF Pro Text";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Text-Regular.otf";                    DestDir: "{autofonts}"; FontInstall: "SF Pro Text";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Text-RegularItalic.otf";              DestDir: "{autofonts}"; FontInstall: "SF Pro Text";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Text-Semibold.otf";                   DestDir: "{autofonts}"; FontInstall: "SF Pro Text";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\SF Pro\SF-Pro-Text-SemiboldItalic.otf";             DestDir: "{autofonts}"; FontInstall: "SF Pro Text";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-Black.otf";           DestDir: "{autofonts}"; FontInstall: "Source Code Pro Black";           Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-BlackIt.otf";         DestDir: "{autofonts}"; FontInstall: "Source Code Pro Black";           Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-Bold.otf";            DestDir: "{autofonts}"; FontInstall: "Source Code Pro";                 Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-BoldIt.otf";          DestDir: "{autofonts}"; FontInstall: "Source Code Pro";                 Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-ExtraLight.otf";      DestDir: "{autofonts}"; FontInstall: "Source Code Pro ExtraLight";      Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-ExtraLightIt.otf";    DestDir: "{autofonts}"; FontInstall: "Source Code Pro ExtraLight";      Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-It.otf";              DestDir: "{autofonts}"; FontInstall: "Source Code Pro";                 Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-Light.otf";           DestDir: "{autofonts}"; FontInstall: "Source Code Pro Light";           Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-LightIt.otf";         DestDir: "{autofonts}"; FontInstall: "Source Code Pro Light";           Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-Medium.otf";          DestDir: "{autofonts}"; FontInstall: "Source Code Pro Medium";          Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-MediumIt.otf";        DestDir: "{autofonts}"; FontInstall: "Source Code Pro Medium";          Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-Regular.otf";         DestDir: "{autofonts}"; FontInstall: "Source Code Pro";                 Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-Semibold.otf";        DestDir: "{autofonts}"; FontInstall: "Source Code Pro SemiBold";        Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Source Code Pro\SourceCodePro-SemiboldIt.otf";      DestDir: "{autofonts}"; FontInstall: "Source Code Pro SemiBold";        Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\Ubuntu-B.ttf";                          DestDir: "{autofonts}"; FontInstall: "Ubuntu";                          Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\Ubuntu-BI.ttf";                         DestDir: "{autofonts}"; FontInstall: "Ubuntu";                          Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\Ubuntu-C.ttf";                          DestDir: "{autofonts}"; FontInstall: "Ubuntu Condensed";                Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\Ubuntu-L.ttf";                          DestDir: "{autofonts}"; FontInstall: "Ubuntu Light";                    Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\Ubuntu-LI.ttf";                         DestDir: "{autofonts}"; FontInstall: "Ubuntu Light";                    Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\Ubuntu-M.ttf";                          DestDir: "{autofonts}"; FontInstall: "Ubuntu Light";                    Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\Ubuntu-MI.ttf";                         DestDir: "{autofonts}"; FontInstall: "Ubuntu Light";                    Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\Ubuntu-R.ttf";                          DestDir: "{autofonts}"; FontInstall: "Ubuntu Mono";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\Ubuntu-RI.ttf";                         DestDir: "{autofonts}"; FontInstall: "Ubuntu Mono";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\Ubuntu-Th.ttf";                         DestDir: "{autofonts}"; FontInstall: "Ubuntu Mono";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\UbuntuMono-B.ttf";                      DestDir: "{autofonts}"; FontInstall: "Ubuntu Mono";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\UbuntuMono-BI.ttf";                     DestDir: "{autofonts}"; FontInstall: "Ubuntu";                          Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\UbuntuMono-R.ttf";                      DestDir: "{autofonts}"; FontInstall: "Ubuntu";                          Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;
Source: "..\modules\fonts\Ubuntu Font\UbuntuMono-RI.ttf";                     DestDir: "{autofonts}"; FontInstall: "Ubuntu Thin";                     Components: fonts;        Flags: onlyifdoesntexist restartreplace uninsneveruninstall uninsrestartdelete;

// Install files to be downloaded
Source: "{tmp}\clink.zip";                                                    DestDir: "{app}\modules\clink";                                         Components: clink;        Flags: deleteafterinstall external uninsrestartdelete;
Source: "{tmp}\git-x64.exe";                                                  DestDir: "{app}\modules\git";                                           Components: git;          Flags: deleteafterinstall external uninsrestartdelete;
Source: "{tmp}\php-x64.zip";                                                  DestDir: "{app}\modules\php";                                           Components: php;          Flags: deleteafterinstall external uninsrestartdelete;
;Source: "{tmp}\kitty.exe";                                                    DestDir: "{app}\modules\putty";                                         Components: putty;        Flags: external uninsrestartdelete;
Source: "{tmp}\putty.exe";                                                    DestDir: "{app}\modules\putty";                                         Components: putty;        Flags: external uninsrestartdelete;
Source: "{tmp}\pscp.exe";                                                     DestDir: "{app}\modules\putty";                                         Components: putty;        Flags: external uninsrestartdelete;
Source: "{tmp}\psftp.exe";                                                    DestDir: "{app}\modules\putty";                                         Components: putty;        Flags: external uninsrestartdelete;
Source: "{tmp}\plink.exe";                                                    DestDir: "{app}\modules\putty";                                         Components: putty;        Flags: external uninsrestartdelete;
Source: "{tmp}\pageant.exe";                                                  DestDir: "{app}\modules\putty";                                         Components: putty;        Flags: external uninsrestartdelete;
Source: "{tmp}\puttygen.exe";                                                 DestDir: "{app}\modules\putty";                                         Components: putty;        Flags: external uninsrestartdelete;

[INI]
// Define KiTTY configuration
;Filename: "{app}\config\putty\kitty.ini";   Section: "KiTTY";   Key: "savemode";    String: "dir";                  Components: putty;    Flags: uninsdeleteentry;
;Filename: "{app}\config\putty\kitty.ini";   Section: "KiTTY";   Key: "configdir";   String: "{app}\config\putty";   Components: putty;    Flags: uninsdeleteentry;

// Define Git installer configuration
Filename: "{app}\config\git\git-x64.ini";   Section: "Setup";   Key: "Dir";         String: "{app}\modules\git";    Components: putty;    Flags: uninsdeleteentry;
Filename: "{app}\config\git\git-x64.ini";   Section: "Setup";   Key: "Group";       String: "{groupname}\Git";      Components: putty;    Flags: uninsdeleteentry;

[Run]
// Unzip Clink
Filename: "{app}\build\7za.exe";              Parameters: "x -aoa -o""{app}\modules\clink\"" -y ""{app}\modules\clink\clink.zip"" ""*""";     Components: clink;        Flags: runhidden;   StatusMsg: "Installing Clink";

// Set Clink as autorun
;Filename: "{app}\modules\clink\clink.bat";    Parameters: "autorun set """"";                                                                 Components: clink;        Flags: runhidden;   StatusMsg: "Installing Clink";
;Filename: "{app}\modules\clink\clink.bat";    Parameters: "autorun install -- --nolog --quiet --profile """"""{app}\config\clink\""""""";     Components: clink;        Flags: runhidden;   StatusMsg: "Installing Clink";

// Unzip Git
Filename: "{app}\modules\git\git-x64.exe";    Parameters: "/LOADINF=""{app}\config\git\git-x64.ini"" /VERYSILENT";                            Components: git;          Flags: runhidden;   StatusMsg: "Installing Git";

// Unzip PHP
Filename: "{app}\build\7za.exe";              Parameters: "x -aoa -o""{app}\modules\php\"" -y ""{app}\modules\php\php-x64.zip"" ""*""";       Components: php;          Flags: runhidden;   StatusMsg: "Installing PHP";

// Create a symbolic link to the "kitty.ini" configuration file
;Filename: "{cmd}";                            Parameters: "/C mklink ""{app}\modules\putty\kitty.ini"" ""{app}\config\putty\kitty.ini""";     Components: putty;        Flags: runhidden;   StatusMsg: "Installing PuTTY";
// Create a symbolic link to "kitty.exe" named "putty.exe" to allow either execuatble name to be used
;Filename: "{cmd}";                            Parameters: "/C mklink ""{app}\modules\putty\putty.exe"" ""{app}\modules\putty\kitty.exe""";    Components: putty;        Flags: runhidden;   StatusMsg: "Installing PuTTY";

// Import CMD Nord Theme registry
Filename: "reg.exe";                          Parameters: "import ""{app}\config\cmd\CMD Nord Theme Only (As Default Settings).reg""";        Tasks: cmd_theme;         Flags: runhidden;   StatusMsg: "Importing CMD Nord Theme registry";
// Import KiTTY Nord Theme registry
;Filename: "reg.exe";                          Parameters: "import ""{app}\config\putty\KiTTY Nord Theme Only (As Default Settings).reg""";    Tasks: kitty_theme;       Flags: runhidden;   StatusMsg: "Importing KiTTY Nord Theme registry";
// Import PuTTY Nord Theme registry
Filename: "reg.exe";                          Parameters: "import ""{app}\config\putty\PuTTY Nord Theme Only (As Default Settings).reg""";    Tasks: putty_theme;       Flags: runhidden;   StatusMsg: "Importing PuTTY Nord Theme registry";

// Import CMD Settings registry
Filename: "reg.exe";                          Parameters: "import ""{app}\config\cmd\CMD Settings (As Default Settings).reg""";               Tasks: cmd_settings;      Flags: runhidden;   StatusMsg: "Importing CMD Settings registry";
// Import KiTTY Settings registry
;Filename: "reg.exe";                          Parameters: "import ""{app}\config\putty\KiTTY Settings (As Default Settings).reg""";           Tasks: kitty_settings;    Flags: runhidden;   StatusMsg: "Importing KiTTY Settings registry";
// Import PuTTY Settings registry
Filename: "reg.exe";                          Parameters: "import ""{app}\config\putty\PuTTY Settings (As Default Settings).reg""";           Tasks: putty_settings;    Flags: runhidden;   StatusMsg: "Importing PuTTY Settings registry";

[Icons]
// Create shortcuts for PuTTY
;Name: "{group}\PuTTY\KiTTY";                  Filename: "{app}\modules\putty\kitty.exe";                                        Components: putty;
Name: "{group}\PuTTY\PuTTY";                  Filename: "{app}\modules\putty\putty.exe";                                        Components: putty;
Name: "{group}\PuTTY\Pageant Key List";       Filename: "{app}\modules\putty\pageant.exe";                                      Components: putty;
Name: "{group}\PuTTY\PuTTY Key Generator";    Filename: "{app}\modules\putty\puttygen.exe";                                     Components: putty;

// Shortcuts for Git are configured in the "{app}\modules\git\git-x64.ini" file

// Create console/terminal shortcuts
Name: "{group}\CMD";                                Filename: "wt.exe";                             Parameters: "-p CMD";                                 IconFilename: "{app}\icons\cmd.ico";
Name: "{group}\Git";                                Filename: "wt.exe";                             Parameters: "-p ""Git Bash""";    Components: git;    IconFilename: "{app}\modules\git\mingw64\share\git\git-for-windows.ico";
Name: "{group}\Git";                                Filename: "wt.exe";                             Parameters: "-p ""Git CMD""";     Components: git;    IconFilename: "{app}\modules\git\mingw64\share\git\git-for-windows.ico";
Name: "{group}\PowerShell";                         Filename: "wt.exe";                             Parameters: "-p PowerShell";                          IconFilename: "{app}\icons\powershell.ico";
Name: "{group}\Ubuntu";                             Filename: "wt.exe";                             Parameters: "-p Ubuntu";                              IconFilename: "{app}\icons\ubuntu.ico";

[Registry]
// "HKCR\*\shell"                       adds the right click entry to all the files
// "HKCR\DesktopBackground\shell"       adds the right click entry to the desktop only
// "HKCR\Directory\background\shell"    adds the right click entry to all the directories (folder, libraries, special folders), when done in the background
// "HKCR\Directory\shell"               adds the right click entry to all the directories (folder, libraries, special folders)
// "HKCR\Drive\shell"                   adds the right click entry to a drive only
// "HKCR\Folder\shell"                  adds the right click entry to a folder only
// "HKCR\LibraryFolder\shell"           adds the right click entry to a library only

// CMD Context Menu
Root: HKCR; Subkey: "Directory\background\shell\wsh_cm_cmd";                  ValueType: string;    ValueName: "";        ValueData: "Open CMD";                          Tasks: cmd_context_menu;          Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\background\shell\wsh_cm_cmd";                  ValueType: string;    ValueName: "Icon";    ValueData: "{app}\icons\cmd.ico";               Tasks: cmd_context_menu;          Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\background\shell\wsh_cm_cmd\command";          ValueType: string;    ValueName: "";        ValueData: "wt.exe -d ""%V."" -p CMD";          Tasks: cmd_context_menu;          Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\shell\wsh_cm_cmd";                             ValueType: string;    ValueName: "";        ValueData: "Open CMD";                          Tasks: cmd_context_menu;          Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\shell\wsh_cm_cmd";                             ValueType: string;    ValueName: "Icon";    ValueData: "{app}\icons\cmd.ico";               Tasks: cmd_context_menu;          Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\shell\wsh_cm_cmd\command";                     ValueType: string;    ValueName: "";        ValueData: "wt.exe -d ""%V."" -p CMD";          Tasks: cmd_context_menu;          Flags: uninsdeletekey;
Root: HKCR; Subkey: "Drive\shell\wsh_cm_cmd";                                 ValueType: string;    ValueName: "";        ValueData: "Open CMD";                          Tasks: cmd_context_menu;          Flags: uninsdeletekey;
Root: HKCR; Subkey: "Drive\shell\wsh_cm_cmd";                                 ValueType: string;    ValueName: "Icon";    ValueData: "{app}\icons\cmd.ico";               Tasks: cmd_context_menu;          Flags: uninsdeletekey;
Root: HKCR; Subkey: "Drive\shell\wsh_cm_cmd\command";                         ValueType: string;    ValueName: "";        ValueData: "wt.exe -d ""%V."" -p CMD";          Tasks: cmd_context_menu;          Flags: uninsdeletekey;

// PowerShell Context Menu
Root: HKCR; Subkey: "Directory\background\shell\wsh_cm_powershell";           ValueType: string;    ValueName: "";        ValueData: "Open PowerShell";                   Tasks: powershell_context_menu;   Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\background\shell\wsh_cm_powershell";           ValueType: string;    ValueName: "Icon";    ValueData: "{app}\icons\powershell.ico";        Tasks: powershell_context_menu;   Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\background\shell\wsh_cm_powershell\command";   ValueType: string;    ValueName: "";        ValueData: "wt.exe -d ""%V."" -p PowerShell";   Tasks: powershell_context_menu;   Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\shell\wsh_cm_powershell";                      ValueType: string;    ValueName: "";        ValueData: "Open PowerShell";                   Tasks: powershell_context_menu;   Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\shell\wsh_cm_powershell";                      ValueType: string;    ValueName: "Icon";    ValueData: "{app}\icons\powershell.ico";        Tasks: powershell_context_menu;   Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\shell\wsh_cm_powershell\command";              ValueType: string;    ValueName: "";        ValueData: "wt.exe -d ""%V."" -p PowerShell";   Tasks: powershell_context_menu;   Flags: uninsdeletekey;
Root: HKCR; Subkey: "Drive\shell\wsh_cm_powershell";                          ValueType: string;    ValueName: "";        ValueData: "Open PowerShell";                   Tasks: powershell_context_menu;   Flags: uninsdeletekey;
Root: HKCR; Subkey: "Drive\shell\wsh_cm_powershell";                          ValueType: string;    ValueName: "Icon";    ValueData: "{app}\icons\powershell.ico";        Tasks: powershell_context_menu;   Flags: uninsdeletekey;
Root: HKCR; Subkey: "Drive\shell\wsh_cm_powershell\command";                  ValueType: string;    ValueName: "";        ValueData: "wt.exe -d ""%V."" -p PowerShell";   Tasks: powershell_context_menu;   Flags: uninsdeletekey;

// Ubuntu Context Menu
Root: HKCR; Subkey: "Directory\background\shell\wsh_cm_ubuntu";               ValueType: string;    ValueName: "";        ValueData: "Open Ubuntu";                       Tasks: ubuntu_context_menu;       Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\background\shell\wsh_cm_ubuntu";               ValueType: string;    ValueName: "Icon";    ValueData: "{app}\icons\ubuntu.ico";            Tasks: ubuntu_context_menu;       Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\background\shell\wsh_cm_ubuntu\command";       ValueType: string;    ValueName: "";        ValueData: "wt.exe -d ""%V."" -p Ubuntu";       Tasks: ubuntu_context_menu;       Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\shell\wsh_cm_ubuntu";                          ValueType: string;    ValueName: "";        ValueData: "Open Ubuntu";                       Tasks: ubuntu_context_menu;       Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\shell\wsh_cm_ubuntu";                          ValueType: string;    ValueName: "Icon";    ValueData: "{app}\icons\ubuntu.ico";            Tasks: ubuntu_context_menu;       Flags: uninsdeletekey;
Root: HKCR; Subkey: "Directory\shell\wsh_cm_ubuntu\command";                  ValueType: string;    ValueName: "";        ValueData: "wt.exe -d ""%V."" -p Ubuntu";       Tasks: ubuntu_context_menu;       Flags: uninsdeletekey;
Root: HKCR; Subkey: "Drive\shell\wsh_cm_ubuntu";                              ValueType: string;    ValueName: "";        ValueData: "Open Ubuntu";                       Tasks: ubuntu_context_menu;       Flags: uninsdeletekey;
Root: HKCR; Subkey: "Drive\shell\wsh_cm_ubuntu";                              ValueType: string;    ValueName: "Icon";    ValueData: "{app}\icons\ubuntu.ico";            Tasks: ubuntu_context_menu;       Flags: uninsdeletekey;
Root: HKCR; Subkey: "Drive\shell\wsh_cm_ubuntu\command";                      ValueType: string;    ValueName: "";        ValueData: "wt.exe -d ""%V."" -p Ubuntu";       Tasks: ubuntu_context_menu;       Flags: uninsdeletekey;

[UninstallRun]
// Execute files
Filename: "{app}\modules\clink\clink.bat";    Parameters: "autorun set """"";                                               RunOnceId: "UninstallClink";            Components: clink;    Flags: runhidden skipifdoesntexist;
Filename: "{app}\modules\git\unins000.exe";   Parameters: "/VERYSILENT";                                                    RunOnceId: "UninstallGit";              Components: git;      Flags: runhidden skipifdoesntexist;

// Delete registry entries for CMD Context Menu (Right Clink)
Filename: "reg.exe";                          Parameters: "delete HKCR\Directory\background\shell\wsh_cm_cmd /f";           RunOnceId: "UninstallCMD_CM";                                 Flags: runhidden;
Filename: "reg.exe";                          Parameters: "delete HKCR\Directory\shell\wsh_cm_cmd /f";                      RunOnceId: "UninstallCMD_CM";                                 Flags: runhidden;
Filename: "reg.exe";                          Parameters: "delete HKCR\Drive\shell\wsh_cm_cmd /f";                          RunOnceId: "UninstallCMD_CM";                                 Flags: runhidden;

// Delete registry entries for PowerShell Context Menu (Right Clink)
Filename: "reg.exe";                          Parameters: "delete HKCR\Directory\background\shell\wsh_cm_powershell /f";    RunOnceId: "UninstallPowerShell_CM";                          Flags: runhidden;
Filename: "reg.exe";                          Parameters: "delete HKCR\Directory\shell\wsh_cm_powershell /f";               RunOnceId: "UninstallPowerShell_CM";                          Flags: runhidden;
Filename: "reg.exe";                          Parameters: "delete HKCR\Drive\shell\wsh_cm_powershell /f";                   RunOnceId: "UninstallPowerShell_CM";                          Flags: runhidden;

// Delete registry entries for Ubuntu Context Menu (Right Clink)
Filename: "reg.exe";                          Parameters: "delete HKCR\Directory\background\shell\wsh_cm_ubuntu /f";        RunOnceId: "UninstallUbuntu_CM";                              Flags: runhidden;
Filename: "reg.exe";                          Parameters: "delete HKCR\Directory\shell\wsh_cm_ubuntu /f";                   RunOnceId: "UninstallUbuntu_CM";                              Flags: runhidden;
Filename: "reg.exe";                          Parameters: "delete HKCR\Drive\shell\wsh_cm_ubuntu /f";                       RunOnceId: "UninstallUbuntu_CM";                              Flags: runhidden;

// Delete registry entry for CMD Nord Theme
;Filename: "reg.exe";                          Parameters: "delete HKCU\Console";                                                                                                          Flags: runhidden;
// Delete registry entry for KiTTY Nord Theme
;Filename: "reg.exe";                          Parameters: "delete HKCU\SOFTWARE\9bis.com\KiTTY\Sessions\Default%20Settings";                                                              Flags: runhidden;
// Delete registry entry for PuTTY Nord Theme
;Filename: "reg.exe";                          Parameters: "delete HKCU\SOFTWARE\SimonTatham\PuTTY\Sessions\Default%20Settings";                                                           Flags: runhidden;

// Delete registry entry for CMD Settings
;Filename: "reg.exe";                          Parameters: "delete HKCU\Console";                                                                                                          Flags: runhidden;
// Delete registry entry for KiTTY Settings
;Filename: "reg.exe";                          Parameters: "delete HKCU\SOFTWARE\9bis.com\KiTTY\Sessions\Default%20Settings";                                                              Flags: runhidden;
// Delete registry entry for PuTTY Settings
;Filename: "reg.exe";                          Parameters: "delete HKCU\SOFTWARE\SimonTatham\PuTTY\Sessions\Default%20Settings";                                                           Flags: runhidden;

[UninstallDelete]
Type: filesandordirs;   Name: "{app}\config\clink\clink_*";
Type: filesandordirs;   Name: "{app}\modules\clink";
Type: filesandordirs;   Name: "{app}\modules\fonts";
;Type: filesandordirs;   Name: "{app}\modules\git";
Type: filesandordirs;   Name: "{app}\modules\putty";
Type: filesandordirs;   Name: "{app}\modules\php";

[Code]
// Use https://www.onlinegdb.com/online_pascal_compiler to test Pascal online

var
  DownloadPage: TDownloadWizardPage;
  WinHttpReq: Variant;
  Haystack: WideString;
  HaystackLength: Integer;
  NeedleStart, NeedleEnd: String;
  NeedleLength, NeedlePos: Integer;
  StrReplaced: String;


// Create the Windows Terminal fragments
var
  JSONDirectory, JSONPath: String;
function CreateFragment(const JSONDirectory, AppName, AppCommandLine, AppIcon, AppBackground, AppCursor, AppForeground, AppGuid: String): Boolean;
begin
  JSONPath:= JSONDirectory+'\'+AppName+'.json';
  AppIcon:= ExpandConstant(AppIcon);
  StringChangeEx(AppIcon, '\', '/', True);
  AppCommandLine:= ExpandConstant(AppCommandLine);
  StringChangeEx(AppCommandLine, '\', '/', True);

  if Length(AppGuid) > 0 then
    AppGuid:= '      "updates": "'+AppGuid+'",';
  if Length(AppBackground) > 0 then
    AppBackground:= '      "background": "'+AppBackground+'",';
  if Length(AppCursor) > 0 then
    AppCursor:= '      "cursorColor": "'+AppCursor+'",';
  if Length(AppForeground) > 0 then
    AppForeground:= '      "foreground": "'+AppForeground+'",';

  if not SaveStringToFile(JSONPath,
    '{'+
    '  "profiles": '+
    '  ['+
    '    {'+
    AppGuid+
    '      "name": "'+AppName+'",'+
    AppBackground+
    '      "bellStyle": ["window", "taskbar"],'+
    '      "closeOnExit": "always",'+
    '      "colorScheme": "Nord",'+
    '      "commandline": "'+AppCommandLine+'",'+
    AppCursor+
    '      "cursorShape": "bar",'+
    '      "elevate": true,'+
    '      "font": {'+
    '        "face": "Source Code Pro"'+
    '      },'+
    AppForeground+
    '      "historySize": 9999,'+
    '      "icon": "'+AppIcon+'",'+
    '      "intenseTextStyle": "bright",'+
    '      "startingDirectory": "%USERPROFILE%"'+
    '    }'+
    '  ]'+
    '}',False) then begin
      MsgBox('Unable to install Windows Terminal Fragment to '+JSONPath, mbError, MB_OK);
      Result:= False;
    end;
end;

function InstallWindowsTerminalFragment(): boolean;
begin
  if IsAdminInstallMode() then
    JSONDirectory:=ExpandConstant('{commonappdata}\Microsoft\Windows Terminal\Fragments\WSH')
  else
    JSONDirectory:=ExpandConstant('{localappdata}\Microsoft\Windows Terminal\Fragments\WSH');

  if not ForceDirectories(JSONDirectory) then begin
    MsgBox('Unable to install Windows Terminal Fragment to '+JSONDirectory, mbError, MB_OK);
    Result:= False;
  end;

  CreateFragment(JSONDirectory, 'CMD',        'cmd.exe /k {app}\config\cmd\init.cmd', '{app}\icons\cmd.ico',                                      '',         '',         '',         '{c23108d6-bbb8-5346-b4e5-ddf0d8577f47}');
  CreateFragment(JSONDirectory, 'PowerShell', 'powershell.exe',                       '{app}\icons\powershell.ico',                               '#81A1C1',  '#ECEFF4',  '#ECEFF4',  '{8bf8204e-56fa-5a42-8a6d-890746e50195}');
  CreateFragment(JSONDirectory, 'Ubuntu',     'ubuntu.exe',                           '{app}\icons\ubuntu.ico',                                   '',         '',         '',         '{273a8952-9a60-5b10-a6d5-0aa00fba00d9}');
  if WizardIsComponentSelected('git') then begin
    CreateFragment(JSONDirectory, 'Git-CMD',  '{app}\modules\git\git-cmd.exe',        '{app}\modules\git\mingw64\share\git\git-for-windows.ico',  '',         '',         '',         '{782c3d40-2b4a-5e6c-a04d-1d3863322958}');
    CreateFragment(JSONDirectory, 'Git-Bash', '{app}\modules\git\bin\bash.exe',       '{app}\modules\git\mingw64\share\git\git-for-windows.ico',  '',         '',         '',         '{1e705aec-228d-5a9a-bad0-65d9fffab1e6}');
  end;
end;

function DownloadClink(const URL, SaveFileAs: String): Boolean;
begin
  WinHttpReq:= CreateOleObject('WinHttp.WinHttpRequest.5.1');
  WinHttpReq.Open('GET', URL, False);
  WinHttpReq.Send('');
  if WinHttpReq.Status <> 200 then begin
    MsgBox(WinHttpReq.StatusText, mbError, MB_OK);
    Result:= False;
  end
  else begin
    NeedleStart:= '"browser_download_url":"';
    NeedleEnd:= '.zip';
    Haystack:= WinHttpReq.ResponseText;
    HaystackLength:= Length(Haystack);
    NeedleLength:= Length(NeedleStart);
    NeedlePos:= Pos(NeedleStart, Haystack) + NeedleLength;
    Haystack:= Copy(Haystack, NeedlePos, HaystackLength);
    NeedleLength:= Length(NeedleEnd);
    NeedlePos:= Pos(NeedleEnd, Haystack) + NeedleLength - 1;
    Haystack:= Copy(Haystack, 0, NeedlePos);

    // Debug message to ensure we extracted the proper URL
    DownloadPage.Add(Haystack, SaveFileAs, '');
    Result:= True;
  end;
end;

function DownloadGit(const URL, SaveFileAs: String): Boolean;
begin
  WinHttpReq:= CreateOleObject('WinHttp.WinHttpRequest.5.1');
  WinHttpReq.Open('GET', URL, False);
  WinHttpReq.Send('');
  if WinHttpReq.Status <> 200 then begin
    MsgBox(WinHttpReq.StatusText, mbError, MB_OK);
    Result:= False;
  end
  else begin
    NeedleStart:= '<a id="auto-download-link" href="';
    NeedleEnd:= '-bit.exe';
    Haystack:= WinHttpReq.ResponseText;
    HaystackLength:= Length(Haystack);
    NeedleLength:= Length(NeedleStart);
    NeedlePos:= Pos(NeedleStart, Haystack) + NeedleLength;
    Haystack:= Copy(Haystack, NeedlePos, HaystackLength);
    NeedleLength:= Length(NeedleEnd);
    NeedlePos:= Pos(NeedleEnd, Haystack) + NeedleLength - 1;
    Haystack:= Copy(Haystack, 0, NeedlePos);

    StrReplaced:= Haystack;
    StringChangeEx(StrReplaced, '32-bit.exe', '64-bit.exe', True);
    Haystack:= StrReplaced;

    // Debug message to ensure we extracted the proper URL
    DownloadPage.Add(Haystack, SaveFileAs, '');
    Result:= True;
  end;
end;

function DownloadPHP(const URL, SaveFileAs: String): Boolean;
begin
  WinHttpReq:= CreateOleObject('WinHttp.WinHttpRequest.5.1');
  WinHttpReq.Open('GET', URL, False);
  WinHttpReq.Send('');
  if WinHttpReq.Status <> 200 then begin
    MsgBox(WinHttpReq.StatusText, mbError, MB_OK);
    Result:= False;
  end
  else begin
    NeedleStart:= '-x64">VS16 x64 Non Thread Safe (';
    Haystack:= WinHttpReq.ResponseText;
    HaystackLength:= Length(Haystack);
    NeedleLength:= Length(NeedleStart);
    NeedlePos:= Pos(NeedleStart, Haystack) + NeedleLength;
    Haystack:= Copy(Haystack, NeedlePos, HaystackLength);

    NeedleStart:= '/downloads/releases/php-';
    NeedleEnd:= '.zip';
    HaystackLength:= Length(Haystack);
    NeedleLength:= Length(NeedleStart);
    NeedlePos:= Pos(NeedleStart, Haystack);
    Haystack:= Copy(Haystack, NeedlePos, HaystackLength);
    NeedleLength:= Length(NeedleEnd);
    NeedlePos:= Pos(NeedleEnd, Haystack) + NeedleLength - 1;
    Haystack:= Copy(Haystack, 0, NeedlePos);

    Haystack:= 'https://windows.php.net' + Haystack;

    // Debug message to ensure we extracted the proper URL
    DownloadPage.Add(Haystack, SaveFileAs, '');
    Result:= True;
  end;
end;

function OnDownloadProgress(const URL, FileName: String; const Progress, ProgressMax: Int64): Boolean;
begin
  if Progress = ProgressMax then
    Log(Format('Successfully downloaded file to {tmp}: %s', [FileName]));
  Result:= True;
end;

procedure InitializeWizard;
begin
  DownloadPage:= CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgress);
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  if CurPageID = wpReady then begin
    InstallWindowsTerminalFragment();

    DownloadPage.Clear;

    if WizardIsComponentSelected('clink') then
      DownloadClink('https://api.github.com/repos/chrisant996/clink/releases/latest', 'clink.zip');
    if WizardIsComponentSelected('git') then
      DownloadGit('https://git-scm.com/download/win', 'git-x64.exe');
    if WizardIsComponentSelected('putty') then begin
      // Download latest version of KiTTY to use in place of PuTTY
      //DownloadPage.Add('http://www.9bis.net/kitty/files/kitty_portable.exe', 'kitty.exe', '');
      // Download latest version of PuTTY
      DownloadPage.Add('https://the.earth.li/~sgtatham/putty/latest/x86/putty.exe', 'putty.exe', '');
      DownloadPage.Add('http://the.earth.li/~sgtatham/putty/latest/x86/pscp.exe', 'pscp.exe', '');
      DownloadPage.Add('http://the.earth.li/~sgtatham/putty/latest/x86/psftp.exe', 'psftp.exe', '');
      DownloadPage.Add('http://the.earth.li/~sgtatham/putty/latest/x86/plink.exe', 'plink.exe', '');
      DownloadPage.Add('http://the.earth.li/~sgtatham/putty/latest/x86/pageant.exe', 'pageant.exe', '');
      DownloadPage.Add('http://the.earth.li/~sgtatham/putty/latest/x86/puttygen.exe', 'puttygen.exe', '');
    end;
    if WizardIsComponentSelected('php') then
      DownloadPHP('https://windows.php.net/download', 'php-x64.zip');

    DownloadPage.Show;
    try
      try
        DownloadPage.Download; // This downloads the files to {tmp}
        Result:= True;
      except
        if DownloadPage.AbortedByUser then
          Log('Aborted by user.')
        else
          SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
        Result:= False;
      end;
    finally
      DownloadPage.Hide;
    end;
  end else
    Result:= True;
end;

// Delete files during uninstall
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  OldFile: string;
begin
  case CurUninstallStep of
    usPostUninstall:
      begin
        OldFile := ExpandConstant('{localappdata}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.wsh_backup.json');
        if FileExists(OldFile) then
          RenameFile(OldFile, ExpandConstant('{localappdata}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'));
      end;
  end;
end;