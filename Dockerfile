FROM runpod/worker-comfyui:5.1.0-base

# Build source for a RunPod image-generation worker.
# Keep the base worker entrypoint intact so the resulting image can be used
# by RunPod Serverless, while still preparing ComfyUI and persistent model links.

WORKDIR /workspace/chat+bild

COPY link_workspace_models.sh /usr/local/bin/link_workspace_models.sh
COPY repair_and_start_imagepod.sh /usr/local/bin/repair_and_start_imagepod.sh

RUN cd /comfyui && git fetch origin master && git reset --hard origin/master \
    && grep -v -E "comfyui-frontend-package|comfyui-workflow-templates" requirements.txt > /tmp/requirements-basic.txt \
    && pip install -r /tmp/requirements-basic.txt \
    && pip install comfyui-frontend-package comfyui-workflow-templates || true \
    && chmod +x /usr/local/bin/link_workspace_models.sh /usr/local/bin/repair_and_start_imagepod.sh \
    && mkdir -p /workspace /runpod-volume \
    && rm -rf /workspace/models \
    && ln -s /runpod-volume/models /workspace/models \
    && /usr/local/bin/link_workspace_models.sh

EXPOSE 8188
