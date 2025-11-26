# Machine Learning Homework Collection

Small collection of practical sessions (TP1, TP2, …). Each TP lives in its own folder (for example `TP5/`).

Quick start (Windows)

Use the included `setup.ps1` script — it creates the virtual environment, activates it, upgrades `pip`, and installs dependencies from `requirements.txt` so you don't have to run the commands manually:

```powershell
.\setup.ps1
# or run the steps manually:
# python -m venv .venv
# .\.venv\Scripts\Activate.ps1
# python -m pip install --upgrade pip
# python -m pip install -r requirements.txt
```

To run a TP script use the `run_tp.py` launcher or call the script directly. Example:

```powershell
python run_tp.py TP5
# or
python TP5\mnist_cnn.py
```
