# Machine Learning Homework Collection

This folder groups practical sessions (TP1, TP2, …) for the ML course. Each TP keeps its own source files and notes under a dedicated subdirectory to keep experiments isolated and easy to grade.

## Current Structure

- `TP5/` – MNIST CNN using TensorFlow/Keras with NumPy and Matplotlib (`TP5/src/mnist_cnn.py`).
- More TP folders can be added beside `TP5/` as new assignments are delivered.

## How to Work on a TP

1. Create/activate the shared virtual environment at the repository root:

   ```powershell
   python -m venv .venv
   .\\.venv\\Scripts\\Activate.ps1
   python -m pip install --upgrade pip
   pip install -r requirements.txt
   ```

2. Navigate to the TP folder you want to run (or reference its paths from the root) and run the corresponding scripts. Example for TP5:

   ```powershell
   python TP5\\mnist_cnn.py
   ```

3. Optional: launch the VS Code task **Run MNIST CNN** to execute TP5 directly via `Tasks: Run Task…`.

Keep additional datasets, outputs, or notes inside the appropriate TP directory so other exercises remain unaffected.

## Run any TP script

Use the provided launcher `run_tp.py` to run a TP script by its folder name. Examples (PowerShell):

```powershell
# Run TP5 using the shared virtual environment if available
python run_tp.py TP5

# Run TP5 but force a specific python interpreter
python run_tp.py TP5 --python .\\venv\\Scripts\\python.exe

# Run TP5 specifying an exact script file
python run_tp.py TP5 --script mnist_cnn.py
```

The launcher will try common script locations (e.g. `TP5/mnist_cnn.py`, `TP5/*.py`, `TP5/src/*.py`) and use `.venv\\Scripts\\python.exe` if present.
