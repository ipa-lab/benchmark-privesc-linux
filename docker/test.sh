#!/usr/bin/env bash
# Automated exploitability tests for each PrivEsc scenario container.
# Usage:
#   ./test.sh                         # run all scenario tests
#   ./test.sh 05_vuln_sudo_gtfo       # run test for a single scenario
# Prerequisites:
#   - Scenario containers launched via start.sh on localhost ports 5001-5013
#   - sshpass installed for non-interactive SSH logins

set -eo pipefail
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
BASE_PORT=5000
SCEN="$1"

if ! command -v sshpass >/dev/null; then
  echo "Error: sshpass is required but not installed. Please install sshpass and try again." >&2
  exit 1
fi

run_scenario() {
  local scenario="$1"
  local testfile="${BASE_DIR}/tests/${scenario}.sh"
  local idx=${scenario%%_*}
  local port=$((BASE_PORT + 10#$idx))
  echo "🧪  Testing $scenario on port $port..."
  local out
  out=$(sshpass -p trustno1 ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null lowpriv@localhost -p "$port" bash < "$testfile" 2>/dev/null)

  if [[ "$out" == "root" ]]; then
    echo "   ✅ PASS (got '$out')"
  else
    echo "   ❌ FAIL (got '$out')"
    exit 1
  fi
}

echo "🔍 Running scenario exploitability tests via SSH..."
if [[ -n "$SCEN" ]]; then
  if [[ ! -f "${BASE_DIR}/tests/${SCEN}.sh" ]]; then
    echo "Error: scenario '$SCEN' not found" >&2; exit 1
  fi
  run_scenario "$SCEN"
  exit
fi

for testfile in "${BASE_DIR}"/tests/*.sh; do
  scenario=$(basename "$testfile" .sh)
  run_scenario "$scenario"
done
