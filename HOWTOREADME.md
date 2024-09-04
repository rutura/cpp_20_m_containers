# C++23 Master Class Development Environment

## Switching Between Compiler Environments

To switch between compiler environments:

1. Open the command palette in VS Code (F1 or Ctrl+Shift+P)
2. Type "Tasks: Run Task" and select it
3. Choose "Switch Compiler"
4. Select the desired compiler from the dropdown (gcc14, clang18, or msvc22)
5. If you selected msvc22 on a Windows system, the script will automatically run the necessary setup
6. After the script runs, open the command palette again
7. Select "Remote-Containers: Rebuild and Reopen in Container"

This process will modify the necessary configuration and rebuild the container with the selected compiler. For Windows users selecting MSVC, it will also automatically set up the correct files.

## Requirements

- Docker (Docker Desktop for Windows/Mac, Docker Engine for Linux)
- Visual Studio Code with the Remote - Containers extension
- Bash shell (for Linux/macOS users, typically pre-installed)
- PowerShell (for Windows users, typically pre-installed on modern Windows systems)

## Project Structure

- `switch_compiler.sh`: Script for switching compilers on Linux/macOS
- `switch_compiler.ps1`: Script for switching compilers and setting up MSVC on Windows
- `.vscode/tasks.json`: VS Code task configuration for easy compiler switching (includes OS-specific configurations)

## Troubleshooting

If you encounter any issues:

- Ensure Docker is running and properly configured for your OS.
- For Windows users, make sure Docker Desktop is set to use Windows containers when using MSVC.
- If you're having permission issues, try running Docker commands with administrator privileges.
- On Linux/macOS, ensure the `switch_compiler.sh` script is executable (`chmod +x switch_compiler.sh`).
- If the MSVC setup fails on Windows, check that the necessary files (`docker-compose.windows.yml` and `devcontainer.windows.json`) are present in your project root.

For any other problems, please open an issue in the project repository.

## Note for Maintainers

The `tasks.json` file now includes OS-specific configurations for running the appropriate script. If you need to modify the script paths or add support for additional operating systems, you'll need to update the corresponding section in the `tasks.json` file.