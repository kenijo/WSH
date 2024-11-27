;-------------------------------------------------------------------------------
; @link         http://kenijo.github.io/WSH
; @description  Inno Setup script for WSH
; @license      MIT License
;-------------------------------------------------------------------------------
// TODO: manage font installation
// TODO: check bookmarked lines and commented lines with ;CHECK
// TODO: at the end, uncomment all the lines with ;OK
// TODO: Add nord, monokai_pro, OneDark themes to vim, cmd, putty, terminal
// TODO: in the installer, create a screen that offers to choose which font to install
// TODO: assign to the different config files, on the fly,  the font selected during installation
// TODO: Update Inno script to generate the Terminal fragments according to the ones defined in ./config/winterm/fragments
// TODO: make sure that all path in config files are defined by inno setup
// TODO: add a warning that all settings will be deleted during uninstallation

#define APP_NAME "WSH"
#define APP_VERSION GetDateTimeString('yymmdd', '-', '') + " build " + GetDateTimeString('hhnnss', '-', '')
#define APP_URL "http://kenijo.github.io/WSH"

#define TERMINAL_SETTINGS "{localappdata}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState";
#define TERMINAL_FRAGMENTS "{localappdata}\Microsoft\Windows Terminal\Fragments";
#define WSL_BASH "\\wsl$\Ubuntu\home\{code:AnsiLowercase|{username}}";

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
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
PrivilegesRequired=lowest
SolidCompression=yes
WizardSizePercent=140
WizardStyle=modern

[Types]
Name: "full";                           Description: "Full Installation";
Name: "custom";                         Description: "Custom Installation";                                                                                         Flags: iscustom;

[Components]
Name: "clink";                          Description: "Clink";                               Types: custom full;                                                     Flags: fixed;
Name: "fonts";                          Description: "Fonts";                               Types: full;
Name: "git";                            Description: "Git";                                 Types: full;
Name: "php7";                           Description: "PHP7";                                Types: full;                                                            Flags: exclusive;
Name: "php8";                           Description: "PHP8";                                Types: full;                                                            Flags: exclusive;
Name: "putty";                          Description: "PuTTY";                               Types: full;

[Tasks]
Name: cmd_context_menu;                 Description: "Add ""Open CMD""";                    GroupDescription: "Context Menu (Right Click):";
Name: cmd_admin_context_menu;           Description: "Add ""Open CMD (Admin)""";            GroupDescription: "Context Menu (Right Click):";                        Flags: unchecked;
Name: powershell_context_menu;          Description: "Add ""Open PowerShell""";             GroupDescription: "Context Menu (Right Click):";
Name: powershell_admin_context_menu;    Description: "Add ""Open PowerShell (Admin)""";     GroupDescription: "Context Menu (Right Click):";                        Flags: unchecked;
Name: ubuntu_context_menu;              Description: "Add ""Open Ubuntu""";                 GroupDescription: "Context Menu (Right Click):";

Name: cmd_theme;                        Description: "Apply CMD Nord Theme";                GroupDescription: "Themes:";
Name: putty_theme;                      Description: "Apply PuTTY Nord Theme";              GroupDescription: "Themes:";                        Components: putty;

Name: bash_settings;                    Description: "Apply Bash Settings";                 GroupDescription: "Settings:";
Name: cmd_settings;                     Description: "Apply CMD Settings";                  GroupDescription: "Settings:";
Name: putty_settings;                   Description: "Apply PuTTY Settings";                GroupDescription: "Settings:";                      Components: putty;
Name: terminal_settings;                Description: "Apply Windows Terminal Settings";     GroupDescription: "Settings:";

[Files]
; Install all files in destination directory
Source: "..\build\*";                           DestDir: "{app}\build";         Excludes: "{OutputBaseFilename}, *git*, _config.yml";   Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\config\*";                          DestDir: "{app}\config";                                                                Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\icons\*";                           DestDir: "{app}\icons";                                                                 Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\modules\*";                         DestDir: "{app}\modules";                                                               Flags: recursesubdirs restartreplace uninsrestartdelete;
Source: "..\README.md";                         DestDir: "{app}";                                                                       Flags: recursesubdirs restartreplace uninsrestartdelete;

; Create a backup of the non WSH files that may be overwritten
Source: "{#WSL_BASH}\.bash_logout";             DestDir: "{app}\config_backup\bash";                    Tasks: bash_settings;           Flags: external recursesubdirs skipifsourcedoesntexist uninsrestartdelete;
Source: "{#WSL_BASH}\.bashrc";                  DestDir: "{app}\config_backup\bash";                    Tasks: bash_settings;           Flags: external recursesubdirs skipifsourcedoesntexist uninsrestartdelete;
Source: "{#WSL_BASH}\.dircolors";               DestDir: "{app}\config_backup\bash";                    Tasks: bash_settings;           Flags: external recursesubdirs skipifsourcedoesntexist uninsrestartdelete;
Source: "{#WSL_BASH}\.inputrc";                 DestDir: "{app}\config_backup\bash";                    Tasks: bash_settings;           Flags: external recursesubdirs skipifsourcedoesntexist uninsrestartdelete;
Source: "{#WSL_BASH}\.vimrc";                   DestDir: "{app}\config_backup\bash";                    Tasks: bash_settings;           Flags: external recursesubdirs skipifsourcedoesntexist uninsrestartdelete;
Source: "{#WSL_BASH}\.vim\*";                   DestDir: "{app}\config_backup\bash\.vim";               Tasks: bash_settings;           Flags: external recursesubdirs skipifsourcedoesntexist uninsrestartdelete;
Source: "{#TERMINAL_SETTINGS}\settings.json";   DestDir: "{app}\config_backup\terminal";                Tasks: terminal_settings;       Flags: external recursesubdirs skipifsourcedoesntexist uninsrestartdelete;
Source: "{#TERMINAL_FRAGMENTS}\*";              DestDir: "{app}\config_backup\terminal\Fragments";      Tasks: terminal_settings;       Flags: external recursesubdirs skipifsourcedoesntexist uninsrestartdelete;

; Install configuration files for the different applications
Source: "{app}\config\bash\*";                  DestDir: "{#WSL_BASH}";                                 Tasks: bash_settings;           Flags: external recursesubdirs restartreplace uninsrestartdelete;
Source: "{app}\config\terminal\settings.json";  DestDir: "{#TERMINAL_SETTINGS}";                        Tasks: terminal_settings;       Flags: external recursesubdirs restartreplace uninsrestartdelete;
Source: "{app}\config\terminal\Fragments\*";    DestDir: "{#TERMINAL_FRAGMENTS}\WSH";                       Tasks: terminal_settings;       Flags: external recursesubdirs restartreplace uninsrestartdelete;

; Install fonts
;CHECKSource: "{app}\modules\fonts\*.otf";            DestDir: "{autofonts}";                                 Components: fonts;              Flags: external onlyifdoesntexist recursesubdirs uninsrestartdelete;
;CHECKSource: "{app}\modules\fonts\*.ttf";            DestDir: "{autofonts}";                                 Components: fonts;              Flags: external onlyifdoesntexist recursesubdirs uninsrestartdelete;

; Install downloaded files
;CHECKSource: "{tmp}\clink.zip";                      DestDir: "{app}\modules\clink";                         Components: clink;              Flags: deleteafterinstall external uninsrestartdelete;
;CHECKSource: "{tmp}\git-x64.exe";                    DestDir: "{app}\modules\git";                           Components: git;                Flags: deleteafterinstall external uninsrestartdelete;
;CHECKSource: "{tmp}\php-x64.zip";                    DestDir: "{app}\modules\php";                           Components: php7;               Flags: deleteafterinstall external uninsrestartdelete;
;CHECKSource: "{tmp}\php-x64.zip";                    DestDir: "{app}\modules\php";                           Components: php8;               Flags: deleteafterinstall external uninsrestartdelete;
;CHECKSource: "{tmp}\putty.exe";                      DestDir: "{app}\modules\putty";                         Components: putty;              Flags: external uninsrestartdelete;
;CHECKSource: "{tmp}\pscp.exe";                       DestDir: "{app}\modules\putty";                         Components: putty;              Flags: external uninsrestartdelete;
;CHECKSource: "{tmp}\psftp.exe";                      DestDir: "{app}\modules\putty";                         Components: putty;              Flags: external uninsrestartdelete;
;CHECKSource: "{tmp}\plink.exe";                      DestDir: "{app}\modules\putty";                         Components: putty;              Flags: external uninsrestartdelete;
;CHECKSource: "{tmp}\pageant.exe";                    DestDir: "{app}\modules\putty";                         Components: putty;              Flags: external uninsrestartdelete;
;CHECKSource: "{tmp}\puttygen.exe";                   DestDir: "{app}\modules\putty";                         Components: putty;              Flags: external uninsrestartdelete;

[INI]
; Define Git installer configuration
Filename: "{app}\config\git\git-x64.ini";       Section: "Setup";   Key: "Dir";     String: "{app}\modules\git";    Components: git;
Filename: "{app}\config\git\git-x64.ini";       Section: "Setup";   Key: "Group";   String: "{groupname}\Git";      Components: git;

[Run]
; Backup CMD and PUTTY settings from registry
FileName: "reg";                                Parameters: "export ""HKCU\Console"" ""{app}\config_backup\cmd_settings.reg"" /y";                                                    Tasks: cmd_settings cmd_theme
FileName: "reg";                                Parameters: "export ""HKCU\SOFTWARE\SimonTatham\PuTTY\Sessions\Default%20Settings"" ""{app}\config_backup\putty_settings.reg"" /y";   Tasks: putty_settings putty_theme

; Unzip and install Clink
Filename: "{app}\build\7za.exe";                Parameters: "x -aoa -o""{app}\modules\clink\"" -y ""{app}\modules\clink\clink.zip"" ""*""";                                                 Components: clink;      Flags: runhidden;   StatusMsg: "Installing Clink";
Filename: "{app}\modules\clink\clink.bat";      Parameters: "autorun install -- --nolog --profile ""{app}\config\clink\""";                                                                 Components: clink;      Flags: runhidden;   StatusMsg: "Installing Clink";

; Unzip and install Git
Filename: "{app}\modules\git\git-x64.exe";      Parameters: "/LOADINF=""{app}\config\git\git-x64.ini"" /VERYSILENT";                                                                        Components: git;        Flags: runhidden;   StatusMsg: "Installing Git";

Filename: "{app}\build\7za.exe";                Parameters: "x -aoa -o""{app}\modules\php\"" -y ""{app}\modules\php\php-x64.zip"" ""*""";                                                   Components: php7;       Flags: runhidden;   StatusMsg: "Installing PHP7";
Filename: "{app}\build\7za.exe";                Parameters: "x -aoa -o""{app}\modules\php\"" -y ""{app}\modules\php\php-x64.zip"" ""*""";                                                   Components: php8;       Flags: runhidden;   StatusMsg: "Installing PHP8";

; Import CMD and PuTTY themes to registry
Filename: "reg";                                Parameters: "import ""{app}\config\clink\themes\cmd_theme_nord.reg""";                                                                      Tasks: cmd_theme;       Flags: runhidden;   StatusMsg: "Importing CMD Nord Theme to registry";
Filename: "reg";                                Parameters: "import ""{app}\config\putty\themes\putty_theme_nord.reg""";                                                                    Tasks: putty_theme;     Flags: runhidden;   StatusMsg: "Importing PuTTY Nord Theme to registry";

; Delete CMD and PuTTY settings from registry before import
FileName: "reg";                                Parameters: "delete ""HKCU\Console"" /f";                                                                                                   Tasks: cmd_settings;    Flags: runhidden;   StatusMsg: "Importing CMD Settings to registry";
FileName: "reg";                                Parameters: "delete ""HKCU\SOFTWARE\SimonTatham\PuTTY\Sessions\Default%20Settings"" /f";                                                    Tasks: putty_settings;  Flags: runhidden;   StatusMsg: "Importing PuTTY Settings to registry";

; Import CMD and PuTTY settings to registry
Filename: "reg";                                Parameters: "import ""{app}\config\clink\cmd_settings.reg""";                                                                               Tasks: cmd_settings;    Flags: runhidden;   StatusMsg: "Importing CMD Settings to registry";
Filename: "reg";                                Parameters: "import ""{app}\config\putty\putty_settings.reg""";                                                                             Tasks: putty_settings;  Flags: runhidden;   StatusMsg: "Importing PuTTY Settings to registry";

[Icons]
; Create shortcuts for PuTTY
Name: "{group}\PuTTY\PuTTY";                    Filename: "{app}\modules\putty\putty.exe";                  Components: putty;
Name: "{group}\PuTTY\Pageant Key List";         Filename: "{app}\modules\putty\pageant.exe";                Components: putty;
Name: "{group}\PuTTY\PuTTY Key Generator";      Filename: "{app}\modules\putty\puttygen.exe";               Components: putty;

; Shortcuts for Git are configured in the "{app}\modules\git\git-x64.ini" file

; Create console/terminal shortcuts
Name: "{group}\CMD";                            Filename: "{autoappdata}\Microsoft\WindowsApps\wt.exe";     Tasks: terminal_settings;   Parameters: "-p CMD";                   IconFilename: "{app}\icons\cmd.ico";
Name: "{group}\CMD (Admin)";                    Filename: "{autoappdata}\Microsoft\WindowsApps\wt.exe";     Tasks: terminal_settings;   Parameters: "-p CMD (Admin)";           IconFilename: "{app}\icons\cmd_admin.ico";
Name: "{group}\PowerShell";                     Filename: "{autoappdata}\Microsoft\WindowsApps\wt.exe";     Tasks: terminal_settings;   Parameters: "-p PowerShell";            IconFilename: "{app}\icons\powershell.ico";
Name: "{group}\PowerShell (Admin)";             Filename: "{autoappdata}\Microsoft\WindowsApps\wt.exe";     Tasks: terminal_settings;   Parameters: "-p PowerShell (Admin)";    IconFilename: "{app}\icons\powershell_admin.ico";
Name: "{group}\Ubuntu";                         Filename: "{autoappdata}\Microsoft\WindowsApps\wt.exe";     Tasks: terminal_settings;   Parameters: "-p Ubuntu";                IconFilename: "{app}\icons\ubuntu.ico";

[Registry]
; If Admin user, for all users
; "HKCR\*\shell"                        Add Context Menu to All File Extensions
; "HKCR\DesktopBackground\shell"        Add Context Menu to Desktop only
; "HKCR\Directory\background\shell"     Add Context Menu to Directory Background (folder, libraries, special folders)
; "HKCR\Directory\shell"                Add Context Menu to Directory (folder, libraries, special folders)
; "HKCR\Drive\shell"                    Add Context Menu to Drive only
; "HKCR\Folder\shell"                   Adds the right click entry to a folder only
; "HKCR\LibraryFolder\shell"            Adds the right click entry to a library only

; If regular user, for that user
; "HKCU\Software\Classes\*\shell"                        Add Context Menu to All File Extensions
; "HKCU\Software\Classes\DesktopBackground\shell"        Add Context Menu to Desktop only
; "HKCU\Software\Classes\Directory\background\shell"     Add Context Menu to Directory Background (folder, libraries, special folders)
; "HKCU\Software\Classes\Directory\shell"                Add Context Menu to Directory (folder, libraries, special folders)
; "HKCU\Software\Classes\Drive\shell"                    Add Context Menu to Drive only
; "HKCU\Software\Classes\Folder\shell"                   Adds the right click entry to a folder only
; "HKCU\Software\Classes\LibraryFolder\shell"            Adds the right click entry to a library only

; Context Menu CMD
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_cmd";                        ValueType: string;  ValueName: "";      ValueData: "Open CMD";                                                                      Tasks: cmd_context_menu;                Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_cmd";                        ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\cmd.ico";                                                           Tasks: cmd_context_menu;                Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_cmd\command";                ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p CMD";                  Tasks: cmd_context_menu;                Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_cmd";                                   ValueType: string;  ValueName: "";      ValueData: "Open CMD";                                                                      Tasks: cmd_context_menu;                Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_cmd";                                   ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\cmd.ico";                                                           Tasks: cmd_context_menu;                Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_cmd\command";                           ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p CMD";                  Tasks: cmd_context_menu;                Flags: uninsdeletekey;

; Context Menu CMD (Admin)
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_cmd_admin";                  ValueType: string;  ValueName: "";      ValueData: "Open CMD (Admin)";                                                              Tasks: cmd_admin_context_menu;          Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_cmd_admin";                  ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\cmd.ico";                                                           Tasks: cmd_admin_context_menu;          Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_cmd_admin\command";          ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p CMD (Admin)";          Tasks: cmd_admin_context_menu;          Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_cmd_admin";                             ValueType: string;  ValueName: "";      ValueData: "Open CMD (Admin)";                                                              Tasks: cmd_admin_context_menu;          Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_cmd_admin";                             ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\cmd.ico";                                                           Tasks: cmd_admin_context_menu;          Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_cmd_admin\command";                     ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p CMD (Admin)";          Tasks: cmd_admin_context_menu;          Flags: uninsdeletekey;

; Context Menu PowerShell
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_powershell";                 ValueType: string;  ValueName: "";      ValueData: "Open PowerShell";                                                               Tasks: powershell_context_menu;         Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_powershell";                 ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\powershell.ico";                                                    Tasks: powershell_context_menu;         Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_powershell\command";         ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p PowerShell";           Tasks: powershell_context_menu;         Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_powershell";                            ValueType: string;  ValueName: "";      ValueData: "Open PowerShell";                                                               Tasks: powershell_context_menu;         Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_powershell";                            ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\powershell.ico";                                                    Tasks: powershell_context_menu;         Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_powershell\command";                    ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p PowerShell";           Tasks: powershell_context_menu;         Flags: uninsdeletekey;

; Context Menu PowerShell (Admin)
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_powershell_admin";           ValueType: string;  ValueName: "";      ValueData: "Open PowerShell (Admin)";                                                       Tasks: powershell_admin_context_menu;   Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_powershell_admin";           ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\powershell.ico";                                                    Tasks: powershell_admin_context_menu;   Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_powershell_admin\command";   ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p PowerShell (Admin)";   Tasks: powershell_admin_context_menu;   Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_powershell_admin";                      ValueType: string;  ValueName: "";      ValueData: "Open PowerShell (Admin)";                                                       Tasks: powershell_admin_context_menu;   Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_powershell_admin";                      ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\powershell.ico";                                                    Tasks: powershell_admin_context_menu;   Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_powershell_admin\command";              ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p PowerShell (Admin)";   Tasks: powershell_admin_context_menu;   Flags: uninsdeletekey;

; Context Menu Ubuntu
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_ubuntu";                     ValueType: string;  ValueName: "";      ValueData: "Open Ubuntu";                                                                   Tasks: ubuntu_context_menu;             Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_ubuntu";                     ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\ubuntu.ico";                                                        Tasks: ubuntu_context_menu;             Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\background\shell\wsh_cm_ubuntu\command";             ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p Ubuntu";               Tasks: ubuntu_context_menu;             Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_ubuntu";                                ValueType: string;  ValueName: "";      ValueData: "Open Ubuntu";                                                                   Tasks: ubuntu_context_menu;             Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_ubuntu";                                ValueType: string;  ValueName: "Icon";  ValueData: "{app}\icons\ubuntu.ico";                                                        Tasks: ubuntu_context_menu;             Flags: uninsdeletekey;
Root: HKCU; Subkey: "Software\Classes\Directory\shell\wsh_cm_ubuntu\command";                        ValueType: string;  ValueName: "";      ValueData: "{autoappdata}\Microsoft\WindowsApps\wt.exe -d ""%V."" -p Ubuntu";               Tasks: ubuntu_context_menu;             Flags: uninsdeletekey;

[UninstallRun]
; Execute uninstallers
Filename: "{app}\modules\clink\clink.bat";      Parameters: "autorun uninstall";                                                                RunOnceId: "UninstallRun01";    Components: clink;                      Flags: runhidden skipifdoesntexist;
Filename: "{app}\modules\git\unins000.exe";     Parameters: "/VERYSILENT";                                                                      RunOnceId: "UninstallRun02";    Components: git;                        Flags: runhidden skipifdoesntexist;

; Delete configuration files for the different applications before restoring backed up non WSH files
Filename: "erase";                              Parameters: "/f /q ""{#WSL_BASH}\.bash_logout""";                                               RunOnceId: "UninstallRun03";    Tasks: bash_settings;                   Flags: runhidden skipifdoesntexist;
Filename: "erase";                              Parameters: "/f /q ""{#WSL_BASH}\.bashrc""";                                                    RunOnceId: "UninstallRun04";    Tasks: bash_settings;                   Flags: runhidden skipifdoesntexist;
Filename: "erase";                              Parameters: "/f /q ""{#WSL_BASH}\.dircolors""";                                                 RunOnceId: "UninstallRun05";    Tasks: bash_settings;                   Flags: runhidden skipifdoesntexist;
Filename: "erase";                              Parameters: "/f /q ""{#WSL_BASH}\.inputrc""";                                                   RunOnceId: "UninstallRun06";    Tasks: bash_settings;                   Flags: runhidden skipifdoesntexist;
Filename: "erase";                              Parameters: "/f /q ""{#WSL_BASH}\.vimrc""";                                                     RunOnceId: "UninstallRun07";    Tasks: bash_settings;                   Flags: runhidden skipifdoesntexist;
Filename: "rmdir";                              Parameters: "/s /q ""{#WSL_BASH}\.vim""";                                                       RunOnceId: "UninstallRun08";    Tasks: bash_settings;                   Flags: runhidden skipifdoesntexist;
Filename: "erase";                              Parameters: "/f /q ""{#TERMINAL_SETTINGS}\settings.json""";                                     RunOnceId: "UninstallRun09";    Tasks: terminal_settings;               Flags: runhidden skipifdoesntexist;
Filename: "rmdir";                              Parameters: "/s /q ""{#TERMINAL_FRAGMENTS}""";                                                  RunOnceId: "UninstallRun10";    Tasks: terminal_settings;               Flags: runhidden skipifdoesntexist;

; Restore backed up non WSH files
Filename: "move";                               Parameters: "/y ""{app}\config_backup\bash\.bash_logout"" ""{#WSL_BASH}""";                     RunOnceId: "UninstallRun11";    Tasks: bash_settings;                   Flags: runhidden skipifdoesntexist;
Filename: "move";                               Parameters: "/y ""{app}\config_backup\bash\.bashrc"" ""{#WSL_BASH}""";                          RunOnceId: "UninstallRun12";    Tasks: bash_settings;                   Flags: runhidden skipifdoesntexist;
Filename: "move";                               Parameters: "/y ""{app}\config_backup\bash\.dircolors"" ""{#WSL_BASH}""";                       RunOnceId: "UninstallRun13";    Tasks: bash_settings;                   Flags: runhidden skipifdoesntexist;
Filename: "move";                               Parameters: "/y ""{app}\config_backup\bash\.inputrc"" ""{#WSL_BASH}""";                         RunOnceId: "UninstallRun14";    Tasks: bash_settings;                   Flags: runhidden skipifdoesntexist;
Filename: "move";                               Parameters: "/y ""{app}\config_backup\bash\.vimrc"" ""{#WSL_BASH}""";                           RunOnceId: "UninstallRun15";    Tasks: bash_settings;                   Flags: runhidden skipifdoesntexist;
Filename: "xcopy";                              Parameters: "/s /y ""{app}\config_backup\bash\.vim\*"" ""{#WSL_BASH}""";                        RunOnceId: "UninstallRun16";    Tasks: bash_settings;                   Flags: runhidden skipifdoesntexist;
Filename: "move";                               Parameters: "/y ""{app}\config_backup\terminal\settings.json"" ""{#TERMINAL_SETTINGS}""";       RunOnceId: "UninstallRun17";    Tasks: terminal_settings;               Flags: runhidden skipifdoesntexist;
Filename: "xcopy";                              Parameters: "/s /y ""{app}\config_backup\terminal\Fragments\*"" ""{#TERMINAL_FRAGMENTS}""";     RunOnceId: "UninstallRun18";    Tasks: terminal_settings;               Flags: runhidden skipifdoesntexist;

; Delete CMD and PuTTY settings from registry
FileName: "reg";                                Parameters: "delete ""HKCU\Console"" /f";                                                       RunOnceId: "UninstallRun19";    Tasks: cmd_settings cmd_theme;          Flags: runhidden skipifdoesntexist;
FileName: "reg";                                Parameters: "delete ""HKCU\SOFTWARE\SimonTatham\PuTTY\Sessions\Default%20Settings"" /f";        RunOnceId: "UninstallRun20";    Tasks: putty_settings putty_theme;      Flags: runhidden skipifdoesntexist;

; Restore backed up CMD and PuTTY settings to registry
Filename: "reg";                                Parameters: "import ""{app}\config_backup\themes\cmd_settings.reg""";                           RunOnceId: "UninstallRun21";    Tasks: cmd_settings cmd_theme;          Flags: runhidden skipifdoesntexist;
Filename: "reg";                                Parameters: "import ""{app}\config_backup\themes\putty_settings.reg""";                         RunOnceId: "UninstallRun22";    Tasks: putty_settings putty_theme;      Flags: runhidden skipifdoesntexist;

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

var JSONDirectory, iconPath: String;
function InstallWindowsTerminalFragment(): boolean;

// Update Windows Terminal fragments
begin
    JSONDirectory:=ExpandConstant('{localappdata}\Microsoft\Windows Terminal\Fragments\WSH')

    if not ForceDirectories(JSONDirectory) then begin
        MsgBox('Unable to install Windows Terminal Fragment to '+JSONDirectory, mbError, MB_OK);
        Result:= False;
    end;

    iconPath:= ExpandConstant({app});
    iconPath:= StringChangeEx(iconPath, '\', '\\', True);

    FileReplaceString(JSONDirectory+'\CMD.json', 'PROFILE_ICON', iconPath + '\\icons\\cmd.ico'));
    FileReplaceString(JSONDirectory+'\CMD (Admin).json', 'PROFILE_ICON', iconPath + '\\icons\\cmd.ico'));
    FileReplaceString(JSONDirectory+'\PowerShell.json', 'PROFILE_ICON', iconPath + '\\icons\\powershell.ico'));
    FileReplaceString(JSONDirectory+'\PowerShell (Admin).json', 'PROFILE_ICON', iconPath + '\\icons\\powershell.ico'));
    FileReplaceString(JSONDirectory+'\Ubuntu.json', 'PROFILE_ICON', iconPath + '\\icons\\ubuntu.ico'));
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
        InstallWindowsTerminalFragment();
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
        if WizardIsComponentSelected('php7') then begin
            DownloadPHP('7', 'vc15');
        end;
        if WizardIsComponentSelected('php8') then begin
            DownloadPHP('8', 'vs17');
        end;

        DownloadPage.Show;

        try
            //CHECKDownloadPage.Download; // This downloads the files to {tmp}
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
