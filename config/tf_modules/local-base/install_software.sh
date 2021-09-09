#!/usr/bin/env bash
set -o errexit
echo "Installing kind"
mkdir -p ~/.opta/kind
curl -Lo ~/.opta/kind/kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
chmod +x ~/.opta/kind/kind
# create registry container unless it already exists
reg_name='opta-local-registry'
reg_port='5000'
running="$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)"
if [ "${running}" != 'true' ]; then
  docker run \
    -d --restart=always -p "127.0.0.1:${reg_port}:5000" --name "${reg_name}" \
    registry:2
fi