# Machine Learning Homework Collection

Small collection of practical sessions (TP1, TP2, …). Each TP lives in its own folder (for example `TP5/`).

Quick start:

- Create and activate the virtual environment at the repository root and install requirements:

  ```powershell
  python -m venv .venv
  .\.venv\Scripts\Activate.ps1
  python -m pip install --upgrade pip
  python -m pip install -r requirements.txt
  ```

- To run a TP script use the `run_tp.py` launcher or call the script directly. Example:

  ```powershell
  python run_tp.py TP5
  # or
  python TP5\mnist_cnn.py
  ```

Windows (PowerShell):

```powershell
.\setup.ps1
```

macOS / Linux:

```bash
./setup.sh
```

Both scripts accept an optional path to a `requirements.txt` file (default: `requirements.txt`).
