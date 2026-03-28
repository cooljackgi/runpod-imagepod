#!/bin/bash
set -euo pipefail

COMFY_DIR="${COMFY_DIR:-/comfyui}"
WORKSPACE_MODELS="${WORKSPACE_MODELS:-/workspace/models}"
RUNPOD_MODELS="${RUNPOD_MODELS:-/runpod-volume/models}"
PYTHON_BIN="${PYTHON_BIN:-/opt/venv/bin/python}"
HOST="${HOST:-0.0.0.0}"
PORT="${PORT:-8188}"

resolve_models_root() {
  if [ -d "$WORKSPACE_MODELS" ]; then
    printf '%s\n' "$WORKSPACE_MODELS"
    return
  fi
  if [ -d "$RUNPOD_MODELS" ]; then
    printf '%s\n' "$RUNPOD_MODELS"
    return
  fi
  printf '%s\n' "$WORKSPACE_MODELS"
}

MODELS_ROOT="$(resolve_models_root)"

echo "== Repair image pod =="
echo "Comfy dir: $COMFY_DIR"
echo "Workspace models: $MODELS_ROOT"

cd "$COMFY_DIR"

grep -v -E "comfyui-frontend-package|comfyui-workflow-templates" "$COMFY_DIR/requirements.txt" > /tmp/requirements-basic.txt
"$PYTHON_BIN" -m pip install -r /tmp/requirements-basic.txt
"$PYTHON_BIN" -m pip install comfyui-frontend-package comfyui-workflow-templates || true

/usr/local/bin/link_workspace_models.sh

echo
echo "== Verify persistent image models =="
find "$MODELS_ROOT" -maxdepth 2 -type f | sort || true

echo
echo "== Restart ComfyUI =="
pkill -f "python main.py" || true
exec "$PYTHON_BIN" "$COMFY_DIR/main.py" --listen "$HOST" --port "$PORT"
