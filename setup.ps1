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

# Detect whether this script was dot-sourced (so activation can persist) or if we're re-entering
$reentry = $false
if ($env:ML_SETUP_REENTRY -eq '1') { $reentry = $true }

$dotSourced = $false
try {
    if ($MyInvocation.Line -match '^[\s]*\.[\s]') { $dotSourced = $true }
} catch {
    $dotSourced = $false
}

$scriptPath = $MyInvocation.MyCommand.Path

if ($reentry) {
    # We're running after being re-invoked to perform activation in the caller session
    Remove-Item Env:ML_SETUP_REENTRY -ErrorAction SilentlyContinue
    Write-Host "Activating virtual environment in the current session..."
    . .\.venv\Scripts\Activate.ps1
    Write-Host "Activation complete. Use 'python' to run commands inside the venv."
    return
}

if ($dotSourced) {
    # Caller dot-sourced the script directly: create/install already done above, now activate in this session
    Write-Host "Dot-sourced: activating virtual environment in the current session..."
    . .\.venv\Scripts\Activate.ps1
    Write-Host "Activation complete. Use 'python' to run commands inside the venv."
    return
} else {
    # Not dot-sourced: perform install above, then re-invoke this script dot-sourced so activation persists
    Write-Host "Setup finished. Dot-sourcing the script to activate the venv in this session..."
    $env:ML_SETUP_REENTRY = '1'
    try {
        . $scriptPath
    } finally {
        Remove-Item Env:ML_SETUP_REENTRY -ErrorAction SilentlyContinue
    }
    return
}