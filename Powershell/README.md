# Powershell Scripts

Visual Studio 2019 with .NET Core 5

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/colinccook/me/master/Powershell/SetupDevMachine-Vs2019-DotNet5.ps1'))
```

Visual Studio 2022 with .NET 6

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/colinccook/me/master/Powershell/SetupDevMachine-Vs2022-DotNet6.ps1'))
```
