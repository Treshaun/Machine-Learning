param(
    [string]$Requirements = ".\requirements.txt"
)

if (-not (Test-Path $Requirements)) {
    Write-Error "Requirements file not found: $Requirements"
    exit 1
}

Write-Host "Creating virtual environment in .\.venv..."
python -m venv .venv
$venvPython = Join-Path -Path (Get-Location) -ChildPath ".venv\Scripts\python.exe"

if (-not (Test-Path $venvPython)) {
    Write-Error "Virtual environment activation script not found. Ensure Python is installed and 'python -m venv .venv' succeeded."
    exit 1
}

Write-Host "Upgrading pip and installing requirements into the venv..."
# Use the venv's python executable so installation works even when the script is not dot-sourced
& $venvPython -m pip install --upgrade pip
& $venvPython -m pip install -r $Requirements

Write-Host "Setup complete. To activate the virtual environment in your current PowerShell session run:"
Write-Host ". .\\.venv\\Scripts\\Activate.ps1"