$testchoco = powershell choco -v
if(-not($testchoco)){
    Write-Output "Please install Chocolatey first before running"
    break;
}

choco upgrade -y chocolatey

#region IIS (as a Windows Feature, one off install)

choco install IIS-WebServerRole --source WindowsFeatures
choco install IIS-ISAPIFilter --source WindowsFeatures
choco install IIS-ISAPIExtensions --source WindowsFeatures
choco install IIS-NetFxExtensibility --source WindowsFeatures
choco install IIS-ASPNET --source WindowsFeatures

choco upgrade -y urlrewrite

#endregion

#region .NET and Visual Studio

choco upgrade -y dotnetfx
choco upgrade -y dotnetcore-sdk
choco upgrade -y dotnet-5.0-windowshosting

choco upgrade -y netfx-4.6.2-devpack

choco upgrade -y visualstudio2019professional
choco upgrade -y visualstudio2019-workload-azure
choco upgrade -y visualstudio2019-workload-netcoretools
choco upgrade -y visualstudio2019-workload-netweb --package-parameters "--includeOptional"
choco upgrade -y visualstudio2019-workload-node

choco upgrade -y codemaid

#endregion

#region SQL Server Developer and Data Tools

choco upgrade -y sql-server-2019
choco upgrade -y ssms

#endregion

#region Azure

choco upgrade -y az.powershell
choco upgrade -y microsoftazurestorageexplorer

#endregion

#region Git

choco upgrade -y git -y --params="'/GitAndUnixToolsOnPath /NoAutoCrlf'"
choco upgrade -y gitextensions
choco upgrade -y winmerge

#endregion

#region Powershell Core

choco upgrade -y powershell-core
choco upgrade -y pester

#endregion

#region Work specific

choco upgrade -y nvm
nvm install 14.16.0
npm install -g @angular/cli
ng analytics off
npm install -g yarn
npm install -g gulp-cli
choco upgrade -y rabbitmq

#endregion

#region Browsers

choco upgrade -y firefox
choco upgrade -y googlechrome
choco upgrade -y chromedriver

#endregion

#region Developer Tools

choco upgrade -y vscode
choco upgrade -y postman
choco upgrade -y fiddler
choco upgrade -y linqpad
choco upgrade -y notepadplusplus
choco upgrade -y microsoft-windows-terminal
choco upgrade -y freedownloadmanager
choco upgrade -y resharper-clt
choco upgrade -y winscp
choco upgrade -y windirstat

#endregion