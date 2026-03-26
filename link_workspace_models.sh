#!/bin/bash
set -euo pipefail

WORKSPACE_MODELS="${WORKSPACE_MODELS:-/workspace/models}"
RUNPOD_MODELS="${RUNPOD_MODELS:-/runpod-volume/models}"
COMFY_MODELS="${COMFY_MODELS:-/comfyui/models}"

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

for subdir in checkpoints loras embeddings controlnet clip vae upscale_models clip_vision ipadapter insightface; do
  mkdir -p "$MODELS_ROOT/$subdir"
done

rm -rf \
  "$COMFY_MODELS/checkpoints" \
  "$COMFY_MODELS/loras" \
  "$COMFY_MODELS/embeddings" \
  "$COMFY_MODELS/controlnet" \
  "$COMFY_MODELS/clip" \
  "$COMFY_MODELS/vae" \
  "$COMFY_MODELS/upscale_models" \
  "$COMFY_MODELS/clip_vision" \
  "$COMFY_MODELS/ipadapter" \
  "$COMFY_MODELS/insightface"

ln -s "$MODELS_ROOT/checkpoints" "$COMFY_MODELS/checkpoints"
ln -s "$MODELS_ROOT/loras" "$COMFY_MODELS/loras"
ln -s "$MODELS_ROOT/embeddings" "$COMFY_MODELS/embeddings"
ln -s "$MODELS_ROOT/controlnet" "$COMFY_MODELS/controlnet"
ln -s "$MODELS_ROOT/clip" "$COMFY_MODELS/clip"
ln -s "$MODELS_ROOT/vae" "$COMFY_MODELS/vae"
ln -s "$MODELS_ROOT/upscale_models" "$COMFY_MODELS/upscale_models"
ln -s "$MODELS_ROOT/clip_vision" "$COMFY_MODELS/clip_vision"
ln -s "$MODELS_ROOT/ipadapter" "$COMFY_MODELS/ipadapter"
ln -s "$MODELS_ROOT/insightface" "$COMFY_MODELS/insightface"

echo "Using models root: $MODELS_ROOT"
echo "ComfyUI image model links updated:"
ls -l "$COMFY_MODELS" | grep -E "checkpoints|loras|embeddings|controlnet|clip|vae|upscale_models|clip_vision|ipadapter|insightface"
