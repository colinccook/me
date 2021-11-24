# Powershell Scripts

I've assembled a few Powershell scripts that I use for personal and work purposes:

### Development machine set-up scripts
Given a new Windows installation, I wanted to automate the most I could when installing pre-requisites on your machine.

Below are the scripts I've written. Install Chocolatey first, then run through the relevant scripts below (can be ran together if desired).

The great thing about this method is that updating everything on your machine is as easy as calling:

```powershell
choco upgrade all -y
```

<details>
  <summary><b>🆕 Setting up a development environment with Visual Studio 2022 and .NET 6</b></summary>
  Visual Studio 2022 has just been released along with .NET 6. This is the install script I'll use to set up my work environment.

  ```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/colinccook/me/master/Powershell/SetupDevMachine-Vs2022-DotNet6.ps1'))
```

</details>

<details>
  <summary><b>Setting up a development environment with Visual Studio 2019 and .NET Core 5</b></summary>
  <br/>Most of my work codebase uses either .NET Core 3.1 or .NET Core 5, so I'd use this if there are incompatibility issues with the above

  ```powershell
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/colinccook/me/master/Powershell/SetupDevMachine-Vs2019-DotNet5.ps1'))
  ```

</details>

### Experimental User Interface scripts

Examples

<details>
  <summary><b>Showing a modal</b></summary>
  <br/>First example of using .NET WinForms with Powershell scripts

  ```powershell
  iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/colinccook/me/master/Powershell/UI/ShowUserInterface.ps1'))
  ```

</details>




