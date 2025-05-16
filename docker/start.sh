#!/usr/bin/env bash
# Start all scenario containers, or a single one if you pass its name.
# Usage:
#   ./start.sh                    # start all
#   ./start.sh 05_vuln_sudo_gtfo  # start just that container
# Each container listens on 127.0.0.1:50XX (5001-5013).

set -euo pipefail
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
PORT_BASE=5001

start_container () {
  local SCEN="$1"
  local IDX="$2"
  local IMAGE="privesc_${SCEN}"
  local NAME="${SCEN}"
  local PORT=$((PORT_BASE + IDX - 1))
  echo "⏳  Preparing container: ${NAME}  (port ${PORT})"
  if docker ps -a --format '{{.Names}}' | grep -wq "${NAME}"; then
    echo "   🛑  Stopping existing container: ${NAME}"
    docker rm -f "${NAME}" > /dev/null
  fi
  echo "   🚀  Launching container: ${NAME}"
  local run_args=( -d --rm --name "${NAME}" -p "${PORT}:22" )
  if [[ "${SCEN}" == "06_vuln_docker" ]]; then
    echo "   🐳  Docker-in-Docker: running in privileged mode and starting Docker inside"
    run_args+=( --privileged "${IMAGE}:latest" sh -c "service docker start && exec /usr/sbin/sshd -D -e" )
  else
    run_args+=( "${IMAGE}:latest" )
  fi
  docker run "${run_args[@]}" > /dev/null

  echo "   ✅  Container '${NAME}' is up on port ${PORT}"
}

if [[ $# -eq 1 ]]; then
  SCEN="$1"
  if [[ ! -f "${BASE_DIR}/scenarios/${SCEN}.sh" ]]; then
    echo "❌ Scenario '${SCEN}' not found."; exit 1; fi
  PREFIX="${SCEN%%_*}"
  IDX=$((10#${PREFIX}))
  start_container "${SCEN}" ${IDX}
else
  for SETUP in "${BASE_DIR}"/scenarios/*.sh; do
    SCEN="$(basename "${SETUP%.*}")"
    PREFIX="${SCEN%%_*}"
    IDX=$((10#${PREFIX}))
    start_container "${SCEN}" "${IDX}"
  done
fi