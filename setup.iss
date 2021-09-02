#define Appid "{{C9A43D9D-E847-4882-84E9-4CF102A0E6EE}"
#define AppName "AppExemple_Launcher"
#define AppVersion "0.1.0"
#define AppAuthor = "Yoann Mosteiro"
#define InstallFileName AppName + "_" + "setup"

#define Copyright AppAuthor + "2021"

[Setup]
AppName={#AppName}
AppVersion={#AppVersion}
AppCopyright={#Copyright}
AppId={{{#Appid}}
DefaultGroupName={#AppName}
OutputBaseFilename={#InstallFileName}
DefaultDirName={userpf}\{#AppName}
PrivilegesRequired=lowest

VersionInfoVersion={#AppVersion}
VersionInfoDescription={#AppName}
VersionInfoCopyright={#Copyright}
VersionInfoProductName={#AppName}
DisableDirPage=no
InfoBeforeFile=LICENSE.txt

OutputDir=.\setup
UninstallDisplayName={#AppName} v{#AppVersion}

Compression=lzma
SolidCompression=yes
WizardStyle=modern
BackSolid=yes
FlatComponentsList=yes
DisableWelcomePage=no

[Icons]
Name: "{group}\{cm:UninstallProgram,{#AppName}}"; Filename: "{uninstallexe}"
[Files]
Source: "dist\launcher.exe"; DestDir: "{app}"; DestName: "launcher.exe"
Source: "dist\settings.json"; DestDir: "{app}"; DestName: "settings.json"
Source: "dist\appexemple.exe"; DestDir: "{app}"; DestName: "appexemple.exe"

[Registry]
Root: HKCR; Subkey: "Directory\Background\shell\{#AppName}"; ValueType: string; ValueName: ""; ValueData: "&Appexemple"; Flags: uninsdeletekey
Root: HKCR; Subkey: "Directory\Background\shell\{#AppName}\command"; ValueType: string; ValueName: ""; ValueData: "{app}\launcher.exe"; Flags: uninsdeletekey


; Pascal code - step customization
; #########################################
[Code]
//Installation steps
(*
Uninstall previous version before re-installing it
32 and 64 bits
*)
procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
  Uninstall: String;
begin
  if (CurStep = ssInstall) then begin
    //32bits
    if RegQueryStringValue(HKLM, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{{#Appid}}_is1', 'UninstallString', Uninstall) then begin
      if MsgBox('Warning: Do you want to remove current installation of {#Appid} before to install ?', mbConfirmation, MB_YESNO) = IDYES then
      begin
        Exec(RemoveQuotes(Uninstall), ' /SILENT', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
      end;
    //64bits
    end else if RegQueryStringValue(HKLM, 'Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{{#Appid}}_is1', 'UninstallString', Uninstall) then begin
      if MsgBox('Warning: Do you want to remove current installation of {#AppName} before to install ?', mbConfirmation, MB_YESNO) = IDYES then
      begin
        Exec(RemoveQuotes(Uninstall), ' /SILENT', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);
      end;
    end;
  end;
end;