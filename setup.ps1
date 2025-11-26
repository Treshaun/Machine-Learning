param(
    [string]$Requirements = ".\requirements.txt",
    [switch]$Force
)

if ($Force -and (Test-Path ".venv")) {
    Write-Host "Force flag specified, removing existing .venv directory..."
    Remove-Item -Path ".venv" -Recurse -Force
}

if (-not (Test-Path $Requirements)) {
    Write-Error "Requirements file not found: $Requirements"
    exit 1
}

Write-Host "Creating virtual environment in .\.venv..."
# Choose a python launcher: prefer `python`, fall back to the Windows `py` launcher
$pythonCmd = $null
$pythonArgs = $null
if (Get-Command python -ErrorAction SilentlyContinue) {
    $pythonCmd = 'python'
} elseif (Get-Command py -ErrorAction SilentlyContinue) {
    # Use the py launcher with -3 to ensure Python 3
    $pythonCmd = 'py'
    $pythonArgs = '-3'
}

if (-not $pythonCmd) {
    Write-Error "Python executable not found. Install Python 3 and ensure 'python' or the 'py' launcher is available in PATH. On Windows, also check Settings > Apps > App execution aliases and disable the alias for 'python'/'python3' if present."
    exit 1
}

Write-Host "Using launcher: $pythonCmd $pythonArgs"
## Require exact Python version 3.11.9
try {
    if ($pythonArgs) {
        $verStr = & $pythonCmd $pythonArgs -c "import sys; print('.'.join(map(str, sys.version_info[:3])))"
    } else {
        $verStr = & $pythonCmd -c "import sys; print('.'.join(map(str, sys.version_info[:3])))"
    }
} catch {
    Write-Error "Failed to query Python version using '$pythonCmd'. Ensure the launcher points to a valid Python installation. $_"
    exit 1
}

if (-not $verStr) {
    Write-Error "Unable to determine Python version. Ensure Python is installed and accessible via the chosen launcher."
    exit 1
}

$verParts = $verStr.Trim() -split '\.' | ForEach-Object { [int]$_ }
if ($verParts.Count -lt 3) { $verParts = $verParts + (0..(2-$verParts.Count) | ForEach-Object {0}) }

if (-not ($verParts[0] -eq 3 -and $verParts[1] -eq 11 -and $verParts[2] -eq 9)) {
    Write-Error "Python $($verStr) is not supported. This project requires exactly Python 3.11.9."
    exit 1
}

try {
    if ($pythonArgs) { & $pythonCmd $pythonArgs -m venv .venv } else { & $pythonCmd -m venv .venv }
} catch {
    Write-Error "Failed to create virtual environment using '$pythonCmd'. Ensure the launcher points to a valid Python 3 installation. $_"
    exit 1
}

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