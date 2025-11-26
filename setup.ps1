param(
    [string]$Requirements = ".\requirements.txt"
)

if (-not (Test-Path $Requirements)) {
    Write-Error "Requirements file not found: $Requirements"
    exit 1
}

Write-Host "Creating virtual environment in .\.venv..."
python -m venv .venv

Write-Host "Activating virtual environment..."
. .\.venv\Scripts\Activate.ps1

Write-Host "Upgrading pip and installing requirements..."
python -m pip install --upgrade pip
python -m pip install -r $Requirements

Write-Host "Setup complete. Activate with: . \.venv\Scripts\Activate.ps1"