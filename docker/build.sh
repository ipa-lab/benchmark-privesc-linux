#!/usr/bin/env bash
# Build one Docker image per scenario script using Dockerfile.
# Usage:  ./build.sh
set -euo pipefail
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🔨  Building PrivEsc scenario images …"
for SETUP in "${BASE_DIR}"/scenarios/*.sh; do
  SCENARIO="$(basename "${SETUP%.*}")"            # 01_vuln_suid_gtfo
  IMAGE="privesc_${SCENARIO}"
  echo "  Building image for ${SCENARIO} (${IMAGE}:latest)..."
  if docker build \
    --build-arg SCENARIO="${SCENARIO}" \
    --build-arg SETUP_SCRIPT="$(basename "$SETUP")" \
    --build-arg HOST_SSH_PUBKEY="${HOST_SSH_PUBKEY:-}" \
    -f "${BASE_DIR}/Dockerfile" \
    -t "${IMAGE}:latest" \
    "${BASE_DIR}"; then
    echo "   ✅ Successfully built ${IMAGE}:latest"
  else
    echo "   ❌ Failed to build ${IMAGE}:latest. Check output above for details."
    exit 1
  fi
done