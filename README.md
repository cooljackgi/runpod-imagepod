# runpod-imagepod

Minimaler Build-Kontext fuer einen RunPod-Bildworker auf Basis von `runpod/worker-comfyui:5.1.0-base`.

Ziel:
- keine Modelle im Image
- Modelle liegen persistent auf `/workspace/models` oder `/runpod-volume/models`
- das Repo dient als Build-Quelle fuer RunPod Serverless / Worker-Builds
- `repair_and_start_imagepod.sh` bleibt als Reparatur-/Debug-Skript fuer Pods nutzbar

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

Wichtig:
- Kein `CMD` im Dockerfile ueberschreiben, damit der Base-Worker-Start von `runpod/worker-comfyui:5.1.0-base` erhalten bleibt.
