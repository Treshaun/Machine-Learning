# Machine Learning Homework Collection

Small collection of practical sessions (TP1, TP2, …). Each TP lives in its own folder (for example `TP5/`).

Quick start:

- Create and activate the virtual environment at the repository root and install requirements:

  ```powershell
  python -m venv .venv
  .\.venv\Scripts\Activate.ps1
  pip install -r requirements.txt
  ```

- To run a TP script use the `run_tp.py` launcher or call the script directly. Example:

  ```powershell
  python run_tp.py TP5
  # or
  python TP5\mnist_cnn.py
  ```

Add new TP folders beside `TP5/` as you complete exercises.

Quick setup scripts

If someone clones the repo they can run the included helper scripts to create a virtual environment and install dependencies.

Windows (PowerShell):

```powershell
.\setup.ps1
```

macOS / Linux:

```bash
./setup.sh
```

Both scripts accept an optional path to a `requirements.txt` file (default: `requirements.txt`).
