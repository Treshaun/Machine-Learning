# MNIST CNN (TP5)

This TP contains a small TensorFlow/Keras convolutional network that trains on the MNIST dataset and shows example predictions.

Prerequisites

- Python 3.10+ and a virtual environment (recommended)
- Install dependencies from the repository `requirements.txt`.

Quick start (PowerShell)

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python TP5\mnist_cnn.py
```

Notes

- The script prints training metrics and shows a small Matplotlib window with sample predictions.
- If you prefer the launcher, use `python run_tp.py TP5` from the repo root.

Troubleshooting

- On Windows, ensure the Microsoft Visual C++ Redistributable is installed for TensorFlow.
- To reduce TensorFlow logging, in PowerShell run:

```powershell
$env:TF_CPP_MIN_LOG_LEVEL = 2
```
