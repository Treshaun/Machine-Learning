# MNIST CNN with TensorFlow

Simple convolutional neural network (CNN) for handwritten digit classification using TensorFlow/Keras, NumPy, and Matplotlib. The script downloads the MNIST dataset, trains a small CNN, evaluates accuracy, and visualizes predictions.

## Prerequisites

- Python 3.10+
- PowerShell (default on Windows)
- Virtual environment recommended for dependency isolation

## Quick Start

1. Create and activate a virtual environment (PowerShell):

   ```powershell
   python -m venv .venv
   .\\.venv\\Scripts\\Activate.ps1
   ```

2. Upgrade pip and install dependencies:

   ```powershell
   python -m pip install --upgrade pip
   pip install -r requirements.txt
   ```

3. Train and evaluate the CNN from the repo root:

   ```powershell
   python TP5\src\mnist_cnn.py
   ```

## VS Code Task

- Open the Command Palette (`Ctrl+Shift+P`) and run **Tasks: Run Task...**.
- Select **Run MNIST CNN** to execute `.\.venv\Scripts\python.exe TP5\src\mnist_cnn.py` inside the workspace.
- The task shares a terminal so you can monitor TensorFlow logs and rerun quickly.

## Outputs

- Console logs show per-epoch metrics and final test accuracy.
- Optional Matplotlib window displays predictions for a sample batch.
- Saved model artifact can be reloaded later for inference.

## Troubleshooting

- TensorFlow needs the Microsoft Visual C++ Redistributable on Windows.
- Use `export TF_CPP_MIN_LOG_LEVEL=2` (or `$env:TF_CPP_MIN_LOG_LEVEL = 2` in PowerShell) to suppress verbose logs.
- If GPU drivers are missing, TensorFlow automatically falls back to CPU.
