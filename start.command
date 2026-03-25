#!/bin/zsh
cd "/Users/j_brinn/Documents/New project/SST"
python3 -m http.server 8000 >/tmp/cais_sst_server.log 2>&1 &
SERVER_PID=$!
sleep 1
open "http://localhost:8000"
wait $SERVER_PID
