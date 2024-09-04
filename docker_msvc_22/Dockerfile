# Use the latest Windows Server Core image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set shell to PowerShell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install Chocolatey
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Visual Studio Build Tools, CMake, Git, and Python
RUN choco install -y visualstudio2022buildtools --package-parameters "--add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --includeOptional --passive --locale en-US" && \
    choco install -y cmake git python

# Install vcpkg
RUN git clone https://github.com/Microsoft/vcpkg.git C:\vcpkg --depth 1 && \
    C:\vcpkg\bootstrap-vcpkg.bat

# Add vcpkg to PATH
RUN $env:Path += ';C:\vcpkg'; \
    [Environment]::SetEnvironmentVariable('Path', $env:Path, [EnvironmentVariableTarget]::Machine)

# Set environment variables for Visual Studio Command Prompt
RUN $vsPath = ${Env:ProgramFiles(x86)} + "\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"; \
    "@echo off `r`ncall `"$vsPath`" `r`n%*" | Out-File -Encoding ASCII C:\vsdevenv.bat

# Set entrypoint to initialize Visual Studio environment
ENTRYPOINT ["C:\\vsdevenv.bat"]

# Set default command
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]

# Set working directory
WORKDIR C:\workspace