# Setting Up Windows Containers: A Comprehensive Guide

This guide outlines the process of setting up Windows containers on a Windows system, including troubleshooting steps for common issues and how to switch between Windows containers and WSL 2 backend.

## Table of Contents
1. [Initial Setup](#initial-setup)
2. [Switching to Windows Containers](#switching-to-windows-containers)
3. [Switching to WSL 2 Backend](#switching-to-wsl-2-backend)
4. [Troubleshooting: Windows Containers Disabled](#troubleshooting-windows-containers-disabled)
5. [Hyper-V Not Supported](#hyper-v-not-supported)
6. [Next Steps](#next-steps)

## Initial Setup

### Prerequisites
- Windows 10 Pro, Enterprise, or Education (Version 1607 or later)
- Docker Desktop installed

### Steps
1. Install Docker Desktop from the official website.
2. During installation, ensure the option to enable Windows containers is selected.

## Switching to Windows Containers

Use the following PowerShell script to switch to Windows containers:

```powershell
# Check if running with administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You need to run this script as an Administrator. Attempting to elevate..."
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Correct path to DockerCli.exe
$dockerCliPath = "C:\Program Files\Docker\Docker\DockerCli.exe"

# Check if DockerCli.exe exists
if (Test-Path $dockerCliPath) {
    Write-Host "Switching Docker to Windows containers..."
    & $dockerCliPath -SwitchDaemon
    
    # Modify Docker Desktop settings
    $settingsPath = "C:\Users\$env:USERNAME\AppData\Roaming\Docker\settings.json"
    if (Test-Path $settingsPath) {
        $settings = Get-Content $settingsPath -Raw | ConvertFrom-Json
        $settings.useWindowsContainers = $true
        $settings.wslEngineEnabled = $false
        $settings | ConvertTo-Json -Depth 32 | Set-Content $settingsPath
        Write-Host "Docker Desktop settings updated to use Windows containers."
    } else {
        Write-Warning "Docker Desktop settings file not found. Please ensure Docker Desktop is installed correctly."
    }
    
    Write-Host "Docker has been switched to Windows containers mode."
} else {
    Write-Error "DockerCli.exe not found at $dockerCliPath. Please ensure Docker is installed correctly."
}

Write-Host "Please restart Docker Desktop to ensure all changes take effect."

# Pause to keep the PowerShell window open
Read-Host -Prompt "Press Enter to exit"
```

Save this script as `SwitchToWindowsContainers.ps1` and run it with PowerShell.

## Switching to WSL 2 Backend

Use the following PowerShell script to switch back to the WSL 2 backend:

```powershell
# Check if running with administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You need to run this script as an Administrator. Attempting to elevate..."
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Correct path to DockerCli.exe
$dockerCliPath = "C:\Program Files\Docker\Docker\DockerCli.exe"

# Check if DockerCli.exe exists
if (Test-Path $dockerCliPath) {
    Write-Host "Switching Docker to use WSL 2 backend..."
    
    # Switch Docker to use WSL 2
    & $dockerCliPath -SwitchLinuxEngine
    
    # Modify Docker Desktop settings
    $settingsPath = "C:\Users\$env:USERNAME\AppData\Roaming\Docker\settings.json"
    if (Test-Path $settingsPath) {
        $settings = Get-Content $settingsPath -Raw | ConvertFrom-Json
        $settings.useWindowsContainers = $false
        $settings.wslEngineEnabled = $true
        $settings | ConvertTo-Json -Depth 32 | Set-Content $settingsPath
        Write-Host "Docker Desktop settings updated to use WSL 2."
    } else {
        Write-Warning "Docker Desktop settings file not found. Please ensure Docker Desktop is installed correctly."
    }
    
    Write-Host "Docker has been switched to use the WSL 2 backend."
} else {
    Write-Error "DockerCli.exe not found at $dockerCliPath. Please ensure Docker is installed correctly."
}

Write-Host "Please restart Docker Desktop to ensure all changes take effect."

# Pause to keep the PowerShell window open
Read-Host -Prompt "Press Enter to exit"
```

Save this script as `SwitchToWSL2Backend.ps1` and run it with PowerShell.

## Troubleshooting: Windows Containers Disabled

If you encounter an error stating that Windows containers have been disabled, follow these steps:

1. Open Docker Desktop settings.
2. Go to the "General" tab.
3. Uncheck "Use the WSL 2 based engine".
4. Check "Use Windows containers instead of Linux containers" or "Enable Windows containers features".
5. Click "Apply & Restart".

If options are greyed out:

1. Close Docker Desktop.
2. Edit the Docker settings file. The correct path is:
   `C:\Users\<YourUsername>\AppData\Roaming\Docker\settings.json`
   Replace `<YourUsername>` with your actual Windows username.
3. Modify the file to include these settings:
   ```json
   {
     "useWindowsContainers": true,
     "wslEngineEnabled": false
   }
   ```
4. Save the file and restart Docker Desktop.

## Hyper-V Not Supported

If you receive an error that Hyper-V is not supported, it's likely due to your Windows version.

### Check Windows Version
Run `winver` in the Run dialog to check your Windows version.

### Options Based on Windows Version

#### Windows 10 Home
1. Upgrade to Windows 10 Pro (recommended).
2. Use Docker Toolbox (not recommended for new installations).
3. Use WSL 2 for Linux containers only (Windows 10 Home, version 2004 and higher).

#### Older Windows Versions
Upgrade to a newer version of Windows (ideally Windows 10 Pro or Windows 11).

#### Alternative: Virtual Machine
Set up a virtual machine running Windows Server or Windows 10 Pro, then install Docker within that VM.

## Next Steps

1. Confirm exact Windows version using `winver`.
2. Determine if Windows containers are specifically required or if Linux containers could be used as an alternative.
3. Based on the Windows version and requirements, choose the most appropriate path forward from the options listed above.
