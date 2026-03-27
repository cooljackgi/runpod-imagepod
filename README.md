# runpod-imagepod

Minimaler Build-Kontext fuer einen RunPod-Bildpod auf Basis von `runpod/worker-comfyui:5.1.0-base`.

Ziel:
- keine Modelle im Image
- Modelle liegen persistent auf `/workspace/models` oder `/runpod-volume/models`
- Start erfolgt ueber `repair_and_start_imagepod.sh`

Erwartete Modellordner:
- `checkpoints`
- `loras`
- `embeddings`
- `controlnet`
- `clip`
- `vae`
- `upscale_models`
- `clip_vision`
- `ipadapter`
- `insightface`

CI:
- GitHub Actions baut und pushed das Image nach `ghcr.io/cooljackgi/runpod-imagepod`
- Tags: `latest` und `sha-<commit>`
