# MNIST CNN (TP5)

This TP contains a small TensorFlow/Keras convolutional network that trains on the MNIST dataset and shows example predictions.

Prerequisites

- Python 3.10+ (or compatible) and a virtual environment (recommended)
- Install dependencies from `requirements.txt` (see Quick start)

Quick start (PowerShell)

Use the repository helper to create and populate a virtual environment:

```powershell
.\setup.ps1
```

Or run the steps manually:

```powershell
python -m venv .venv
. .\\.venv\\Scripts\\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python TP5\\mnist_cnn.py
```

Notes

- This TP uses the global virtual environment (`.venv`) located at the repository root.
- The script prints training metrics and shows a small Matplotlib window with sample predictions.
- You can also run the TP using the launcher from the repo root:

```powershell
python run_tp.py TP5
```

Troubleshooting

- On Windows, ensure the Microsoft Visual C++ Redistributable is installed for TensorFlow.
- To reduce TensorFlow logging, in PowerShell run:

```powershell
$env:TF_CPP_MIN_LOG_LEVEL = 2
```
