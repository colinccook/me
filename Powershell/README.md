# Powershell Scripts

I've assembled a few Powershell scripts that I use for personal and work purposes:

<details>
  <summary><b>🆕 Setting up a development environment with Visual Studio 2022 and .NET 6</b></summary>
  <br/>This script installs all the necessary Chocolatey packages for development with at my workplace<br/>
  Visual Studio 2022 has just been released along with .NET 6. This is the install script I'll use to set up my work environment.

  ```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/colinccook/me/master/Powershell/SetupDevMachine-Vs2022-DotNet6.ps1'))
```

</details>

<details>
  <summary><b>Setting up a development environment with Visual Studio 2019 and .NET Core 5</b></summary>
  <br/>This is an older script that installs all the necessary Chocolatey packages for development with at my workplace
  <br/>Most of my work codebase uses either .NET Core 3.1 or .NET Core 5, so I'd use this if there are incompatibility issues with the above

  ```powershell
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/colinccook/me/master/Powershell/SetupDevMachine-Vs2019-DotNet5.ps1'))
  ```

</details>


