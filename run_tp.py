"""run_tp.py — run a TP script by TP name

Usage examples (PowerShell):
  python run_tp.py TP5
  python run_tp.py TP5 --script mnist_cnn.py
  python run_tp.py TP5 --python .\.venv\Scripts\python.exe

Behavior:
- If `.venv\Scripts\python.exe` exists it will be used by default.
- The script tries these locations (in order):
    1) TP_DIR/<script> (when --script given)
    2) TP_DIR/<script> (default script name)
    3) TP_DIR/*.py (first match excluding __init__)
    4) TP_DIR/src/*.py (first match)

Exits with the same return code as the executed script.
"""
from __future__ import annotations
import argparse
import os
import subprocess
import sys
from pathlib import Path

DEFAULT_SCRIPT_NAMES = ["mnist_cnn.py", "main.py", "run.py"]


def find_python_executable(preferred: Path) -> str | None:
    if preferred.exists():
        return str(preferred)
    # fallback: system python
    return None


def find_script(tp_dir: Path, script_name: str | None = None) -> Path | None:
    # 1) explicit script
    if script_name:
        candidate = tp_dir / script_name
        if candidate.exists():
            return candidate
    # 2) common default names in tp_dir
    for name in DEFAULT_SCRIPT_NAMES:
        candidate = tp_dir / name
        if candidate.exists():
            return candidate
    # 3) any .py files in tp_dir (exclude __init__)
    for p in sorted(tp_dir.glob("*.py")):
        if p.name == "__init__.py":
            continue
        return p
    # 4) look under src/
    src_dir = tp_dir / "src"
    if src_dir.exists() and src_dir.is_dir():
        for p in sorted(src_dir.glob("*.py")):
            if p.name == "__init__.py":
                continue
            return p
    return None


def main(argv: list[str] | None = None) -> int:
    argv = argv if argv is not None else sys.argv[1:]
    parser = argparse.ArgumentParser(description="Run a TP script by TP name (e.g., TP5)")
    parser.add_argument("tp", help="TP directory name (e.g., TP5)")
    parser.add_argument("--script", help="Specific script filename inside the TP folder")
    parser.add_argument("--python", help="Path to python executable to use (overrides .venv detection)")
    parser.add_argument("--cwd", help="Working directory to run the script from (defaults to repo root)")
    args = parser.parse_args(argv)

    repo_root = Path.cwd()
    tp_dir = repo_root / args.tp
    if not tp_dir.exists() or not tp_dir.is_dir():
        print(f"ERROR: TP directory not found: {tp_dir}")
        return 2

    script_path = find_script(tp_dir, args.script)
    if script_path is None:
        print("ERROR: No runnable Python script found in:", tp_dir)
        return 3

    # choose python
    venv_python = repo_root / ".venv" / "Scripts" / "python.exe"
    python_exec = None
    if args.python:
        python_exec = args.python
    else:
        python_exec = find_python_executable(venv_python) or sys.executable

    run_cwd = Path(args.cwd) if args.cwd else repo_root

    print(f"Running TP '{args.tp}' -> {script_path.relative_to(repo_root)}")
    print(f"Using Python: {python_exec}")
    print(f"CWD: {run_cwd}")

    cmd = [str(python_exec), str(script_path)]
    try:
        result = subprocess.run(cmd, cwd=str(run_cwd))
        return result.returncode
    except KeyboardInterrupt:
        print("Execution interrupted by user.")
        return 130
    except Exception as e:
        print("Failed to run script:", e)
        return 4


if __name__ == "__main__":
    raise SystemExit(main())
