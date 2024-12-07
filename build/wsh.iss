;-------------------------------------------------------------------------------
; @link         http://kenijo.github.io/WSH
; @description  Inno Setup script for WSH
; @license      MIT License
;-------------------------------------------------------------------------------

#define APP_NAME "WSH"
#define APP_VERSION GetDateTimeString('yymmdd', '-', '') + " build " + GetDateTimeString('hhnnss', '-', '')
#define APP_URL "http://kenijo.github.io/WSH"

#define TERMINAL_SETTINGS "{localappdata}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState";
#define TERMINAL_FRAGMENTS "{localappdata}\Microsoft\Windows Terminal\Fragments";
#define WSL_BASH "\\wsl$\Ubuntu\home\{code:AnsiLowercase|{username}}";

; The value of this parameter is the name of the font as stored in the registry or WIN.INI
#define WSH_FONT "Hasklig";

[Setup]
; The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{86FC8442-27A7-4FE8-BEDD-E3AB83AE2922}
AppName={#APP_NAME}
AppVersion={#APP_VERSION}
AppVerName={#APP_NAME} {#APP_VERSION}
AppPublisherURL={#APP_URL}
AppSupportURL={#APP_URL}
AppUpdatesURL={#APP_URL}

AllowCancelDuringInstall=no
AllowNoIcons=no
DefaultDirName={commonpf}\{#APP_NAME}
DefaultGroupName={#APP_NAME}
ShowComponentSizes=no

OutputBaseFilename=WSH
OutputDir=.
SetupIconFile=..\icons\wsh.ico

; "ArchitecturesAllowed=x64compatible" specifies that Setup cannot run
; on anything but x64 and Windows 11 on Arm.
ArchitecturesAllowed=x64compatible
; "ArchitecturesInstallIn64BitMode=x64compatible" requests that the
; install be done in "64-bit mode" on x64 or Windows 11 on Arm,
; meaning it should use the native 64-bit Program Files directory and
; the 64-bit view of the registry.
ArchitecturesInstallIn64BitMode=x64compatible
Compression=lzma
; Remove the following line to run in administrative install mode (install for all users.)
; PrivilegesRequired=lowest
; Need to run in administrative mode to install fonts
SolidCompression=yes
WizardSizePercent=140
WizardStyle=modern

[Types]
Name: "full";                   Description: "Full Installation";
Name: "custom";                 Description: "Custom Installation";                                                                     Flags: iscustom;

[Components]
Name: clink;                    Description: "Clink";                               Types: full;
Name: clink\settings;           Description: "Apply CMD Settings";                  Types: full;
Name: fonts;                    Description: "Font: {#WSH_FONT}";                   Types: full;
Name: git;                      Description: "Git";                                 Types: full;
Name: php;                      Description: "PHP";
Name: php\php7;                 Description: "PHP7";                                                                                    Flags: exclusive;
Name: php\php8;                 Description: "PHP8";                                Types: full;                                        Flags: exclusive;
Name: putty;                    Description: "PuTTY";                               Types: full;
Name: putty\settings;           Description: "Apply PuTTY Settings";                Types: full;
Name: terminal;                 Description: "Apply Windows Terminal Settings";     Types: full;
Name: theme;                    Description: "Theme";
Name: theme\none;               Description: "No Theme";                                                                                Flags: exclusive;
Name: theme\nord;               Description: "Nord";                                                                                    Flags: exclusive;
Name: theme\monokai_pro;        Description: "Monokai Pro";                         Types: full;                                        Flags: exclusive;
Name: theme\onedark;            Description: "OneDark";                                                                                 Flags: exclusive;
Name: wsh_bash;                 Description: "Apply WSL Bash Settings";             Types: full;

[Tasks]
Name: cm_cmd;                   Description: "Add ""Open CMD""";                    GroupDescription: "Context Menu (Right Click):";
Name: cm_cmd_admin;             Description: "Add ""Open CMD (Admin)""";            GroupDescription: "Context Menu (Right Click):";    Flags: unchecked;
Name: cm_powershell;            Description: "Add ""Open PowerShell""";             GroupDescription: "Context Menu (Right Click):";
Name: cm_powershell_admin;      Description: "Add ""Open PowerShell (Admin)""";     GroupDescription: "Context Menu (Right Click):";    Flags: unchecked;
Name: cm_ubuntu;                Description: "Add ""Open Ubuntu""";                 GroupDescription: "Context Menu (Right Click):";

[Files]
; Create a backup of the non WSH files that may be overwritten
Source: "{#WSL_BASH}\.bash_aliases";            DestDir: "{app}\config_backup\bash";                    Components: wsh_bash;       Flags: external skipifsourcedoesntexist uninsrestartdelete;
Source: "{#WSL_BASH}\.bash_logout";             DestDir: "{app}\config_backup\bash";                    Components: wsh_bash;       Flags: external skipifsourcedoesntexist uninsrestartdelete;
Source: "{#WSL_BASH}\.bashrc";                  DestDir: "{app}\config_backup\bash";                    Components: wsh_bash;       Flags: external skipifsourcedoesntexist uninsrestartdelete;
Source: "{#WSL_BASH}\.dircolors";               DestDir: "{app}\config_backup\bash";                    Components: wsh_bash;       Flags: external skipifsourcedoesntexist uninsrestartdelete;
Source: "{#WSL_BASH}\.inputrc";                 DestDir: "{app}\config_backup\bash";                    Components: wsh_bash;       Flags: external skipifsourcedoesntexist uninsrestartdelete;
Source: "{#WSL_BASH}\.vim\*";                   DestDir: "{app}\config_backup\bash\.vim";               Components: wsh_bash;       Flags: external recursesubdirs skipifsourcedoesntexist uninsrestartdelete;
Source: "{#WSL_BASH}\.vimrc";                   DestDir: "{app}\config_backup\bash";                    Components: wsh_bash;       Flags: external skipifsourcedoesntexist uninsrestartdelete;
Source: "{#TERMINAL_SETTINGS}\settings.json";   DestDir: "{app}\config_backup\terminal";                Components: terminal;       Flags: external skipifsourcedoesntexist uninsrestartdelete;
Source: "{#TERMINAL_FRAGMENTS}\WSH\*";          DestDir: "{app}\config_backup\terminal\Fragments";      Components: terminal;       Flags: external recursesubdirs skipifsourcedoesntexist uninsrestartdelete;

; Install all files in destination directory
Source: "..\build\*";                           DestDir: "{app}\build";     Excludes: "{OutputBaseFilename}, *git*, _config.yml";   Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\config\*";                          DestDir: "{app}\config";                                                            Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\icons\*";                           DestDir: "{app}\icons";                                                             Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\modules\*";                         DestDir: "{app}\modules";                                                           Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\README.md";                         DestDir: "{app}";                                                                   Flags: restartreplace uninsrestartdelete;
Source: "..\build\FontReg\FontReg.exe";         DestDir: "{app}\modules\fonts";                                                     Flags: restartreplace uninsrestartdelete;

; Install configuration files for the different applications
; Flagged to not be uninstalled. Instead they will be uninstallled through the section [UninstallRun] to properly restore backed up files
Source: "..\config\bash\*";                     DestDir: "{#WSL_BASH}";                                 Components: wsh_bash;       Flags: recursesubdirs restartreplace uninsneveruninstall;
Source: "..\config\terminal\settings.json";     DestDir: "{#TERMINAL_SETTINGS}";                        Components: terminal;       Flags: restartreplace uninsneveruninstall;
Source: "..\config\terminal\Fragments\*";       DestDir: "{#TERMINAL_FRAGMENTS}\WSH";                   Components: terminal;       Flags: recursesubdirs restartreplace uninsneveruninstall;

; Install downloaded files
Source: "{tmp}\clink.zip";                      DestDir: "{app}\modules\clink";                         Components: clink;          Flags: deleteafterinstall external uninsrestartdelete;
Source: "{tmp}\git-x64.exe";                    DestDir: "{app}\modules\git";                           Components: git;            Flags: deleteafterinstall external uninsrestartdelete;
Source: "{tmp}\php-x64.zip";                    DestDir: "{app}\modules\php";                           Components: php\php7;       Flags: deleteafterinstall external uninsrestartdelete;
Source: "{tmp}\php-x64.zip";                    DestDir: "{app}\modules\php";                           Components: php\php8;       Flags: deleteafterinstall external uninsrestartdelete;
Source: "{tmp}\putty.exe";                      DestDir: "{app}\modules\putty";                         Components: putty;          Flags: external uninsrestartdelete;
Source: "{tmp}\pscp.exe";                       DestDir: "{app}\modules\putty";                         Components: putty;          Flags: external uninsrestartdelete;
Source: "{tmp}\psftp.exe";                      DestDir: "{app}\modules\putty";                         Components: putty;          Flags: external uninsrestartdelete;
Source: "{tmp}\plink.exe";                      DestDir: "{app}\modules\putty";                         Components: putty;          Flags: external uninsrestartdelete;
Source: "{tmp}\pageant.exe";                    DestDir: "{app}\modules\putty";                         Components: putty;          Flags: external uninsrestartdelete;
Source: "{tmp}\puttygen.exe";                   DestDir: "{app}\modules\putty";                         Components: putty;          Flags: external uninsrestartdelete;

[INI]
; Define Git installer configuration
Filename: "{app}\config\git\git-x64.ini";       Section: "Setup";   Key: "Dir";     String: "{app}\modules\git";    Components: git;
Filename: "{app}\config\git\git-x64.ini";       Section: "Setup";   Key: "Group";   String: "{groupname}\Git";      Components: git;

[Run]
; Register fonts with FontReg
FileName: "{app}\modules\fonts\FontReg.exe";    Parameters: "/copy";                                                                                                                    Flags: runhidden;   StatusMsg: "Registering Fonts";

; Backup CMD and PUTTY settings from registry
FileName: "{sys}\reg";                          Parameters: "export ""HKCU\Console"" ""{app}\config_backup\cmd_settings.reg"" /y";                                                      Flags: runhidden;   StatusMsg: "Backing up CMD";
FileName: "{sys}\reg";                          Parameters: "export ""HKCU\SOFTWARE\SimonTatham\PuTTY\Sessions\Default%20Settings"" ""{app}\config_backup\putty_settings.reg"" /y";     Flags: runhidden;   StatusMsg: "Backing up PuTTY";

; Unzip and install Clink
Filename: "{app}\build\7z\7za.exe";             Parameters: "x -aoa -o""{app}\modules\clink\"" -y ""{app}\modules\clink\clink.zip"" ""*""";         Components: clink;                  Flags: runhidden;   StatusMsg: "Installing Clink";
Filename: "{app}\modules\clink\clink.bat";      Parameters: "autorun install -- --nolog --profile ""{app}\config\clink\""";                         Components: clink;                  Flags: runhidden;   StatusMsg: "Installing PuTTY";

; Unzip and install Git
Filename: "{app}\modules\git\git-x64.exe";      Parameters: "/LOADINF=""{app}\config\git\git-x64.ini"" /VERYSILENT";                                Components: git;                    Flags: runhidden;   StatusMsg: "Installing Git";

; Unzip and install PHP
Filename: "{app}\build\7z\7za.exe";             Parameters: "x -aoa -o""{app}\modules\php\"" -y ""{app}\modules\php\php-x64.zip"" ""*""";           Components: php\php7;               Flags: runhidden;   StatusMsg: "Installing PHP7";
Filename: "{app}\build\7z\7za.exe";             Parameters: "x -aoa -o""{app}\modules\php\"" -y ""{app}\modules\php\php-x64.zip"" ""*""";           Components: php\php8;               Flags: runhidden;   StatusMsg: "Installing PHP8";

; Import CMD and PuTTY themes to registry
Filename: "{sys}\reg.exe";                      Parameters: "import ""{app}\config\clink\themes\cmd_theme_nord.reg""";                              Components: theme\nord;             Flags: runhidden;   StatusMsg: "Importing CMD Nord Theme";
Filename: "{sys}\reg.exe";                      Parameters: "import ""{app}\config\clink\themes\cmd_theme_monokai_pro.reg""";                       Components: theme\monokai_pro;      Flags: runhidden;   StatusMsg: "Importing CMD Monokai Pro Theme";
Filename: "{sys}\reg.exe";                      Parameters: "import ""{app}\config\clink\themes\cmd_theme_onedark.reg""";                           Components: theme\onedark;          Flags: runhidden;   StatusMsg: "Importing CMD OneDark Theme";
Filename: "{sys}\reg.exe";                      Parameters: "import ""{app}\config\putty\themes\putty_theme_nord.reg""";                            Components: theme\nord;             Flags: runhidden;   StatusMsg: "Importing PuTTY Nord Theme";
Filename: "{sys}\reg.exe";                      Parameters: "import ""{app}\config\putty\themes\putty_theme_monokai_pro.reg""";                     Components: theme\monokai_pro;      Flags: runhidden;   StatusMsg: "Importing PuTTY Monokai Pro Theme";
Filename: "{sys}\reg.exe";                      Parameters: "import ""{app}\config\putty\themes\putty_theme_onedark.reg""";                         Components: theme\onedark;          Flags: runhidden;   StatusMsg: "Importing PuTTY OneDark Theme";

; Import CMD and PuTTY settings to registry
Filename: "{sys}\reg.exe";                      Parameters: "import ""{app}\config\clink\cmd_settings.reg""";                                       Components: clink\settings;         Flags: runhidden;   StatusMsg: "Importing CMD Settings";
Filename: "{sys}\reg.exe";                      Parameters: "import ""{app}\config\putty\putty_settings.reg""";                                     Components: putty\settings;         Flags: runhidden;   StatusMsg: "Importing PuTTY Settings";

[Icons]
; Create shortcuts for PuTTY
Name: "{group}\PuTTY\PuTTY";                    Filename: "{app}\modules\putty\putty.exe";                                                          Components: putty;
Name: "{group}\PuTTY\Pageant Key List";         Filename: "{app}\modules\putty\pageant.exe";                                                        Components: putty;
Name: "{group}\PuTTY\PuTTY Key Generator";      Filename: "{app}\modules\putty\puttygen.exe";                                                       Components: putty;

; Shortcuts for Git are configured in the "{app}\modules\git\git-x64.ini" file
; Currently disabled in git-x64.ini

; Create console/terminal shortcuts
Name: "{group}\CMD";                            Filename: "{autoappdata}\Microsoft\WindowsApps\wt.exe";     Parameters: "-p CMD";                   Components: terminal;   IconFilename: "{app}\icons\cmd.ico";
Name: "{group}\CMD (Admin)";                    Filename: "{autoappdata}\Microsoft\WindowsApps\wt.exe";     Parameters: "-p CMD (Admin)";           Components: terminal;   IconFilename: "{app}\icons\cmd_admin.ico";
Name: "{group}\PowerShell";                     Filename: "{autoappdata}\Microsoft\WindowsApps\wt.exe";     Parameters: "-p PowerShell";            Components: terminal;   IconFilename: "{app}\icons\powershell.ico";
Name: "{group}\PowerShell (Admin)";             Filename: "{autoappdata}\Microsoft\WindowsApps\wt.exe";     Parameters: "-p PowerShell (Admin)";    Components: terminal;   IconFilename: "{app}\icons\powershell_admin.ico";
Name: "{group}\Ubuntu";                         Filename: "{autoappdata}\Microsoft\WindowsApps\wt.exe";     Parameters: "-p Ubuntu";                Components: terminal;   IconFilename: "{app}\icons\ubuntu.ico";

[Registry]
; Update font in the registry for CMD and PuTTY
Root: HKCU; Subkey: "Console";                                                  ValueType: string;  ValueName: "FaceName";  ValueData: "{#WSH_FONT}";                                                                                   Tasks: cm_cmd;                Flags: uninsdeletekey;
Root: HKCU; Subkey: "SOFTWARE\SimonTatham\PuTTY\Sessions\Default%20Settings";   ValueType: string;  ValueName: "Font";      ValueData: "{#WSH_FONT}";                                                                                   Tasks: cm_cmd;                Flags: uninsdeletekey;

; If Admin user, for all users
; "HKCR\*\shell"                                        Add Context Menu to All File Extensions
; "HKCR\DesktopBackground\shell"                        Add Context Menu to Desktop only
; "HKCR\Directory\background\shell"                     Add Context Menu to Directory Background (folder, libraries, special folders)
; "HKCR\Directory\shell"                                Add Context Menu to Directory (folder, libraries, special folders)
; "HKCR\Drive\shell"                                    Add Context Menu to Drive only
; "HKCR\Folder\shell"                                   Adds the right click entry to a folder only
; "HKCR\LibraryFolder\shell"                            Adds the right click entry to a library only

; If regular user, for that user
; "HKCU\Software\Classes\*\shell"                       Add Context Menu to All File Extensions
; "HKCU\Software\Classes\DesktopBackground\shell"       Add Context Menu to Desktop only
; "HKCU\Software\Classes\Directory\background\shell"    Add Context Menu to Directory Background (folder, libraries, special folders)
; "HKCU\Software\Classes\Directory\shell"               Add Context Menu to Directory (folder, libraries, special folders)
; "HKCU\Software\Classes\Drive\shell"                   Add Context Menu to Drive only
; "HKCU\Software\Classes\Folder\shell"                  Adds the right click entry to a folder only
; "HKCU\Software\Classes\LibraryFolder\shell"           Adds the right click entry to a library only

; Context Menu CMD
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_cmd";                       ValueType: string;  ValueName: "";      ValueData: "Open CMD";                                                                      Tasks: cm_cmd;                  Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_cmd";                       ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\cmd.ico";                                                           Tasks: cm_cmd;                  Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_cmd\command";               ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p CMD";                  Tasks: cm_cmd;                  Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_cmd";                                  ValueType: string;  ValueName: "";      ValueData: "Open CMD";                                                                      Tasks: cm_cmd;                  Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_cmd";                                  ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\cmd.ico";                                                           Tasks: cm_cmd;                  Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_cmd\command";                          ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p CMD";                  Tasks: cm_cmd;                  Flags: uninsdeletekey;

; Context Menu CMD (Admin)
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_cmd_admin";                 ValueType: string;  ValueName: "";      ValueData: "Open CMD (Admin)";                                                              Tasks: cm_cmd_admin;            Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_cmd_admin";                 ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\cmd.ico";                                                           Tasks: cm_cmd_admin;            Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_cmd_admin\command";         ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p CMD (Admin)";          Tasks: cm_cmd_admin;            Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_cmd_admin";                            ValueType: string;  ValueName: "";      ValueData: "Open CMD (Admin)";                                                              Tasks: cm_cmd_admin;            Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_cmd_admin";                            ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\cmd.ico";                                                           Tasks: cm_cmd_admin;            Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_cmd_admin\command";                    ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p CMD (Admin)";          Tasks: cm_cmd_admin;            Flags: uninsdeletekey;

; Context Menu PowerShell
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_powershell";                ValueType: string;  ValueName: "";      ValueData: "Open PowerShell";                                                               Tasks: cm_powershell;           Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_powershell";                ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\powershell.ico";                                                    Tasks: cm_powershell;           Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_powershell\command";        ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p PowerShell";           Tasks: cm_powershell;           Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_powershell";                           ValueType: string;  ValueName: "";      ValueData: "Open PowerShell";                                                               Tasks: cm_powershell;           Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_powershell";                           ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\powershell.ico";                                                    Tasks: cm_powershell;           Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_powershell\command";                   ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p PowerShell";           Tasks: cm_powershell;           Flags: uninsdeletekey;

; Context Menu PowerShell (Admin)
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_powershell_admin";          ValueType: string;  ValueName: "";      ValueData: "Open PowerShell (Admin)";                                                       Tasks: cm_powershell_admin;     Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_powershell_admin";          ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\powershell.ico";                                                    Tasks: cm_powershell_admin;     Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_powershell_admin\command";  ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p PowerShell (Admin)";   Tasks: cm_powershell_admin;     Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_powershell_admin";                     ValueType: string;  ValueName: "";      ValueData: "Open PowerShell (Admin)";                                                       Tasks: cm_powershell_admin;     Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_powershell_admin";                     ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\powershell.ico";                                                    Tasks: cm_powershell_admin;     Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_powershell_admin\command";             ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p PowerShell (Admin)";   Tasks: cm_powershell_admin;     Flags: uninsdeletekey;

; Context Menu Ubuntu
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_ubuntu";                    ValueType: string;  ValueName: "";      ValueData: "Open Ubuntu";                                                                   Tasks: cm_ubuntu;               Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_ubuntu";                    ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\ubuntu.ico";                                                        Tasks: cm_ubuntu;               Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_ubuntu\command";            ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p Ubuntu";               Tasks: cm_ubuntu;               Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_ubuntu";                               ValueType: string;  ValueName: "";      ValueData: "Open Ubuntu";                                                                   Tasks: cm_ubuntu;               Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_ubuntu";                               ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\ubuntu.ico";                                                        Tasks: cm_ubuntu;               Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_ubuntu\command";                       ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p Ubuntu";               Tasks: cm_ubuntu;               Flags: uninsdeletekey;

[UninstallRun]
; Execute uninstallers
Filename: "{app}\modules\clink\clink.bat";  Parameters: "autorun uninstall";                                                                            RunOnceId: "UninstallWSH01";    Components: clink;              Flags: runhidden skipifdoesntexist;
Filename: "{app}\modules\git\unins000.exe"; Parameters: "/VERYSILENT";                                                                                  RunOnceId: "UninstallWSH02";    Components: git;                Flags: runhidden skipifdoesntexist;

; Delete configuration files for the different applications before restoring backed up non WSH files
Filename: "{cmd}";                          Parameters: "/c erase /f /q ""{#WSL_BASH}\.bash_aliases""";                                                 RunOnceId: "UninstallWSH03";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c erase /f /q ""{#WSL_BASH}\.bash_history""";                                                 RunOnceId: "UninstallWSH04";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c erase /f /q ""{#WSL_BASH}\.bash_logout""";                                                  RunOnceId: "UninstallWSH05";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c erase /f /q ""{#WSL_BASH}\.bashrc""";                                                       RunOnceId: "UninstallWSH06";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c erase /f /q ""{#WSL_BASH}\.dircolors""";                                                    RunOnceId: "UninstallWSH07";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c erase /f /q ""{#WSL_BASH}\.inputrc""";                                                      RunOnceId: "UninstallWSH08";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c erase /f /q ""{#WSL_BASH}\.viminfo""";                                                      RunOnceId: "UninstallWSH09";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c erase /f /q ""{#WSL_BASH}\.vimrc""";                                                        RunOnceId: "UninstallWSH10";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c rmdir /s /q ""{#WSL_BASH}\.vim""";                                                          RunOnceId: "UninstallWSH11";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c erase /f /q ""{#TERMINAL_SETTINGS}\settings.json""";                                        RunOnceId: "UninstallWSH12";    Components: terminal;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c rmdir /s /q ""{#TERMINAL_FRAGMENTS}\WSH""";                                                 RunOnceId: "UninstallWSH13";    Components: terminal;           Flags: runhidden skipifdoesntexist;

; Restore backed up non WSH files
Filename: "{cmd}";                          Parameters: "/c move /y ""{app}\config_backup\bash\.bash_aliases"" ""{#WSL_BASH}""";                        RunOnceId: "UninstallWSH14";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c move /y ""{app}\config_backup\bash\.bash_logout"" ""{#WSL_BASH}""";                         RunOnceId: "UninstallWSH15";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c move /y ""{app}\config_backup\bash\.bashrc"" ""{#WSL_BASH}""";                              RunOnceId: "UninstallWSH16";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c move /y ""{app}\config_backup\bash\.dircolors"" ""{#WSL_BASH}""";                           RunOnceId: "UninstallWSH17";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c move /y ""{app}\config_backup\bash\.inputrc"" ""{#WSL_BASH}""";                             RunOnceId: "UninstallWSH18";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c move /y ""{app}\config_backup\bash\.vimrc"" ""{#WSL_BASH}""";                               RunOnceId: "UninstallWSH19";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c xcopy /s /y ""{app}\config_backup\bash\.vim\*"" ""{#WSL_BASH}""";                           RunOnceId: "UninstallWSH20";    Components: wsh_bash;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c move /y ""{app}\config_backup\terminal\settings.json"" ""{#TERMINAL_SETTINGS}""";           RunOnceId: "UninstallWSH21";    Components: terminal;           Flags: runhidden skipifdoesntexist;
Filename: "{cmd}";                          Parameters: "/c xcopy /i /s /y ""{app}\config_backup\terminal\Fragments"" ""{#TERMINAL_FRAGMENTS}\WSH""";   RunOnceId: "UninstallWSH22";    Components: terminal;           Flags: runhidden skipifdoesntexist;

; Delete CMD and PuTTY settings from registry
Filename: "{sys}\reg.exe";                  Parameters: "delete ""HKCU\Console"" /f";                                                                   RunOnceId: "UninstallWSH23";                                    Flags: runhidden skipifdoesntexist;
Filename: "{sys}\reg.exe";                  Parameters: "delete ""HKCU\SOFTWARE\SimonTatham\PuTTY\Sessions\Default%20Settings"" /f";                    RunOnceId: "UninstallWSH24";                                    Flags: runhidden skipifdoesntexist;

; Restore backed up CMD and PuTTY settings to registry
Filename: "{sys}\reg.exe";                  Parameters: "import ""{app}\config_backup\themes\cmd_settings.reg""";                                       RunOnceId: "UninstallWSH25";    Components: clink\settings;     Flags: runhidden skipifdoesntexist;
Filename: "{sys}\reg.exe";                  Parameters: "import ""{app}\config_backup\themes\putty_settings.reg""";                                     RunOnceId: "UninstallWSH26";    Components: putty\settings;     Flags: runhidden skipifdoesntexist;

[UninstallDelete]
; Delete left over files and folders
Type: filesandordirs;   Name: "{app}\build\*";
Type: filesandordirs;   Name: "{app}\config\*";
Type: filesandordirs;   Name: "{app}\config_backup\*";
Type: filesandordirs;   Name: "{app}\icons\*";
Type: filesandordirs;   Name: "{app}\modules\*";

[Code]
// Use https://www.tutorialspoint.com/compile_pascal_online.php to test Pascal online

// Replace string in file
function FileReplaceString(const FileName, SearchString, ReplaceString: string): Boolean;
var
    MyFile : TStrings;
    MyText : string;
begin
    MyFile := TStringList.Create;

    try
        result := true;

        try
            MyFile.LoadFromFile(FileName);
            MyText := MyFile.Text;

            { Only save if text has been changed. }
            if StringChangeEx(MyText, SearchString, ReplaceString, True) > 0 then begin
                MyFile.Text := MyText;
                MyFile.SaveToFile(FileName);
            end;
        except
            result := false;
        end;
    finally
        MyFile.Free;
    end;
end;

// Update variable placeholders in config files
var clinkPath, iconPath, terminalPath, wshBashPath: String;
var findRecord: TFindRec;
function updateVariablePlaceholder(): boolean;
begin
    clinkPath:=ExpandConstant('{app}\config\clink')
    FileReplaceString(clinkPath + '\clink_settings', '<WSH_CLINK_PATH>', clinkPath);

    iconPath:= ExpandConstant('{app}');
    StringChangeEx(iconPath, '\', '\\', True);

    terminalPath:=ExpandConstant('{#TERMINAL_FRAGMENTS}\WSH')
    if FindFirst (terminalPath + '\*.json', findRecord) then begin
        repeat
            FileReplaceString(terminalPath + '\' + findRecord.Name, '<WSH_ICON_PATH>', iconPath);
        until
            not FindNext(findRecord);
    end;
    FindClose(findRecord);

    terminalPath:=ExpandConstant('{#TERMINAL_SETTINGS}')
    wshBashPath:=ExpandConstant('{#WSL_BASH}')

    FileReplaceString(terminalPath + '\settings.json', '<WSH_FONT>', '{#WSH_FONT}');

    if WizardIsComponentSelected('theme\nord') then begin
        FileReplaceString(terminalPath + '\settings.json', '<WSH_THEME>', 'Nord');
        FileReplaceString(wshBashPath + '\.vimrc', '<WSH_THEME>', 'nord');
    end;
    if WizardIsComponentSelected('theme\monokai_pro') then begin
        FileReplaceString(terminalPath + '\settings.json', '<WSH_THEME>', 'Monokai Pro');
        FileReplaceString(wshBashPath + '\.vimrc', '<WSH_THEME>', 'monokai_pro');
    end;
    if WizardIsComponentSelected('theme\onedark') then begin
        FileReplaceString(terminalPath + '\settings.json', '<WSH_THEME>', 'OneDark');
        FileReplaceString(wshBashPath + '\.vimrc', '<WSH_THEME>', 'onedark');
    end;

    Result:= True;
end;

// Download artifact from Github
var
    DownloadPage: TDownloadWizardPage;
    WinHttpReq: Variant;
    jsonResponseLength, stringLength, stringPosition: Integer;
    downloadLink, jsonResponse, jsonUrl, version: String;
function DownloadFromGithub(Const repository, stringStart, stringEnd, filenameStart, filenameEnd, downloadFile: String): Boolean;
begin
    jsonUrl:= 'https://api.github.com/repos/' + repository + '/releases/latest';

    WinHttpReq:= CreateOleObject('WinHttp.WinHttpRequest.5.1');
    WinHttpReq.Open('GET', jsonUrl, False);
    WinHttpReq.Send('');

    if WinHttpReq.Status <> 200 then begin
        MsgBox(WinHttpReq.StatusText, mbError, MB_OK);
        Result:= False;
    end else begin
        jsonResponse:= WinHttpReq.ResponseText;

        // Get the lenght of the downloaded JSON
        jsonResponseLength:= Length(jsonResponse);

        // Get the length of stringStart
        stringLength:= Length(stringStart);

        // Find the position of the end of stringStart in the JSON
        stringPosition:= Pos(stringStart, jsonResponse) + stringLength;

        // Copy the substring of the JSON that starts at the end of stringStart
        jsonResponse:= Copy(jsonResponse, stringPosition, jsonResponseLength);

        // Find the position of the begining of stringEnd in the JSON
        stringPosition:= Pos(stringEnd, jsonResponse) - 1;

        // Copy the substring of the JSON that ends at the start of stringEnd
        version:= Copy(jsonResponse, 0, stringPosition);
        downloadLink:= 'https://github.com/' + repository + '/releases/latest/download/' + filenameStart + version + filenameEnd;

        DownloadPage.Add(downloadLink, downloadFile, '');
        Result:= True;
    end;
end;

// Download PHP based on selected
var searchString: String;
function DownloadPHP(Const requestedVersion, visualStudioCompiler: String): Boolean;
begin
    jsonUrl:= 'https://www.php.net/releases/index.php?version=' + requestedVersion + '&json&max=1';

    WinHttpReq:= CreateOleObject('WinHttp.WinHttpRequest.5.1');
    WinHttpReq.Open('GET', jsonUrl, False);
    WinHttpReq.Send('');

    if WinHttpReq.Status <> 200 then begin
        MsgBox(WinHttpReq.StatusText, mbError, MB_OK);
        Result:= False;
    end else begin
        jsonResponse:= WinHttpReq.ResponseText;

        searchString:= '"';

        // Get the lenght of the downloaded JSON
        jsonResponseLength:= Length(jsonResponse);

        // Get the length of searchString
        stringLength:= Length(searchString);

        // Find the position of the end of searchString in the JSON
        stringPosition:= Pos(searchString, jsonResponse) + stringLength;

        // Copy the substring of the JSON that starts at the end of searchString
        jsonResponse:= Copy(jsonResponse, stringPosition, jsonResponseLength);

        // Find the position of the begining of searchString in the JSON
        stringPosition:= Pos(searchString, jsonResponse) - 1;

        // Copy the substring of the JSON that ends at the start of searchString
        version:= Copy(jsonResponse, 0, stringPosition);
        downloadLink:= 'https://windows.php.net/downloads/releases/php-' + version + '-nts-Win32-' + visualStudioCompiler + '-x64.zip';

        DownloadPage.Add(downloadLink, 'php-x64.zip', '');
        Result:= True;
    end;
end;

// Manage the download progress status
function OnDownloadProgress(const URL, FileName: String; const Progress, ProgressMax: Int64): Boolean;
begin
    if Progress = ProgressMax then begin
        Log(Format('Successfully downloaded file to {tmp}: %s', [FileName]));
    end;
    Result:= True;
end;

// Initatialize the Wizard
procedure InitializeWizard;
begin
    DownloadPage:= CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgress);
end;

// Executed when clicking on the 'Next' button
function NextButtonClick(CurPageID: Integer): Boolean;
begin
    if CurPageID = wpFinished then begin
        updateVariablePlaceholder();
    end;

    if CurPageID = wpReady then begin
        DownloadPage.Clear;

        if WizardIsComponentSelected('clink') then begin
            DownloadFromGithub(
                'chrisant996/clink',
                'name":"clink.', '.zip',
                'clink.', '.zip',
                'clink.zip'
            );
        end;
        if WizardIsComponentSelected('git') then begin
            DownloadFromGithub(
                'git-for-windows/git',
                'name":"Git-', '-32-bit.exe',
                'Git-', '-64-bit.exe',
                'git-x64.exe'
            );
        end;
        if WizardIsComponentSelected('putty') then begin
            // Download latest version of PuTTY
            DownloadPage.Add('https://the.earth.li/~sgtatham/putty/latest/x86/putty.exe', 'putty.exe', '');
            DownloadPage.Add('http://the.earth.li/~sgtatham/putty/latest/x86/pscp.exe', 'pscp.exe', '');
            DownloadPage.Add('http://the.earth.li/~sgtatham/putty/latest/x86/psftp.exe', 'psftp.exe', '');
            DownloadPage.Add('http://the.earth.li/~sgtatham/putty/latest/x86/plink.exe', 'plink.exe', '');
            DownloadPage.Add('http://the.earth.li/~sgtatham/putty/latest/x86/pageant.exe', 'pageant.exe', '');
            DownloadPage.Add('http://the.earth.li/~sgtatham/putty/latest/x86/puttygen.exe', 'puttygen.exe', '');
        end;
        if WizardIsComponentSelected('php\php7') then begin
            DownloadPHP('7', 'vc15');
        end;
        if WizardIsComponentSelected('php\php8') then begin
            DownloadPHP('8', 'vs17');
        end;

        DownloadPage.Show;

        try
            DownloadPage.Download; // This downloads the files to {tmp}
            Result:= True;
        except
            if DownloadPage.AbortedByUser then begin
                Log('Aborted by user.')
            end else begin
                SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
                Result:= False;
            end;
        finally
            DownloadPage.Hide;
        end;
    end else begin
        Result:= True;
    end;
end;
