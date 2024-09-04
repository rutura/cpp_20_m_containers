param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("gcc14", "clang18", "msvc22")]
    [string]$Compiler
)

function Setup-Windows-Environment {
    Write-Host "Setting up Windows development environment..."
    
    # Rename docker-compose file
    if (Test-Path "docker-compose.windows.yml") {
        Move-Item -Force "docker-compose.windows.yml" "docker-compose.yml"
        Write-Host "Renamed docker-compose.windows.yml to docker-compose.yml"
    } else {
        Write-Host "Warning: docker-compose.windows.yml not found"
    }

    # Set up devcontainer.json
    if (Test-Path "devcontainer.windows.json") {
        if (-not (Test-Path ".devcontainer")) {
            New-Item -ItemType Directory -Force -Path ".devcontainer"
        }
        Copy-Item -Force "devcontainer.windows.json" ".devcontainer/devcontainer.json"
        Write-Host "Copied devcontainer.windows.json to .devcontainer/devcontainer.json"
    } else {
        Write-Host "Warning: devcontainer.windows.json not found"
    }

    Write-Host "Windows setup complete."
}

$devcontainerPath = ".devcontainer/devcontainer.json"

if (!(Test-Path $devcontainerPath)) {
    Write-Host "Error: devcontainer.json not found. Make sure you're in the correct directory."
    exit 1
}

$content = Get-Content $devcontainerPath -Raw
$newContent = $content -replace '"service": ".*"', "`"service`": `"$Compiler`""
$newContent | Set-Content $devcontainerPath

Write-Host "Switched to $Compiler."

if ($Compiler -eq "msvc22") {
    Write-Host "Running setup for MSVC..."
    Setup-Windows-Environment
}

Write-Host "Please rebuild and reopen the container in VS Code."
Write-Host "Use 'Remote-Containers: Rebuild and Reopen in Container' from the command palette."