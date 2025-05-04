#!/usr/bin/env python3
import subprocess, json, time, sys

disconnected = json.dumps({
                "text": "",
                "class": "disconnected",
                "alt": "disconnected"})

while True:
    output = disconnected
    result = subprocess.run("nmcli con show -a", shell=True, capture_output=True, text=True).stdout
    for con in result.splitlines()[1:]:
        if "wireguard" in con:
            output = json.dumps({
                "text": con.split(" ")[0]+" ",
                "class": "",
                "alt": "connected"})
            break
    sys.stdout.write(output + "\n")
    sys.stdout.flush()
    time.sleep(2)