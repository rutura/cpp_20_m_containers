param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("gcc14", "clang18", "msvc22")]
    [string]$Compiler
)

$devcontainerDir = ".devcontainer"
$devcontainerPath = "$devcontainerDir/devcontainer.json"
$dockerComposePath = "docker-compose.yml"

function Setup-Environment {
    param(
        [string]$EnvType
    )
    Write-Host "Setting up $EnvType development environment..."
    
    $devcontainerEnvPath = "$devcontainerDir/devcontainer.$EnvType.json"
    $dockerComposeEnvPath = "docker-compose.$EnvType.yml"

    if (Test-Path $devcontainerEnvPath) {
        Copy-Item -Force $devcontainerEnvPath $devcontainerPath
        Write-Host "Copied $devcontainerEnvPath to $devcontainerPath"
    } else {
        Write-Host "Warning: $devcontainerEnvPath not found"
    }

    if (Test-Path $dockerComposeEnvPath) {
        Copy-Item -Force $dockerComposeEnvPath $dockerComposePath
        Write-Host "Copied $dockerComposeEnvPath to $dockerComposePath"
    } else {
        Write-Host "Warning: $dockerComposeEnvPath not found"
    }

    Write-Host "$EnvType setup complete."
}

if (!(Test-Path $devcontainerDir)) {
    Write-Host "Error: .devcontainer folder not found. Make sure you're in the correct directory."
    exit 1
}

if ($Compiler -eq "msvc22") {
    Setup-Environment "windows"
} else {
    Setup-Environment "unix"
}

$content = Get-Content $devcontainerPath -Raw
$newContent = $content -replace '"service": ".*"', "`"service`": `"$Compiler`""
$newContent | Set-Content $devcontainerPath

Write-Host "Switched to $Compiler."
Write-Host "Please rebuild and reopen the container in VS Code."
Write-Host "Use 'Remote-Containers: Rebuild and Reopen in Container' from the command palette."