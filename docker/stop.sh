#!/usr/bin/env bash
# Stop one or all PrivEsc scenario containers.
# Usage:
#   ./stop.sh              # stop all
#   ./stop.sh <scenario>   # stop just that container (e.g., 05_vuln_sudo_gtfo)

set -euo pipefail
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

action_stop() {
  local NAME="$1"
  echo "🛑  Stopping container: ${NAME}"
  if docker ps -a --format '{{.Names}}' | grep -wq "${NAME}"; then
    docker rm -f "${NAME}" > /dev/null
    echo "   ✅  Container '${NAME}' stopped."
  else
    echo "   🚫  No container named '${NAME}' found."
  fi
}

if [[ $# -eq 1 ]]; then
  SCEN="$1"
  if [[ ! -f "${BASE_DIR}/scenarios/${SCEN}.sh" ]]; then
    echo "❌ Scenario '${SCEN}' not found."; exit 1
  fi
  action_stop "${SCEN}"
else
  for SETUP in "${BASE_DIR}"/scenarios/*.sh; do
    SCEN="$(basename "${SETUP%.*}")"
    action_stop "${SCEN}"
  done
fi
