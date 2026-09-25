#!/bin/python
'''
not sure how best to explain this file but ill try...
i have alot of config things i switch between when going portable and when im plugged in sitting at a desk
so thought id make a script to do that!

checked items are:
* power profile
* refresh rate
* screen animations
* brightness settings
(removed volume/mute as ill have a headset connected anyway, which the system handles on its own)

this will just be a basic daemon (i think thats the right term) that will switch back and forth between two profiles wether im connected to a external monitor or not
when it notices a difference itll ask to switch to the other profile, which then it will save the other one with the current settings.

this file will also probably replace the oler toggleRefreshRate.sh, toggle_hypr_keyword.sh, and cyclePowerProfile.sh, just cause its cleaner

since hyprland switching to lua, it is much easier to do the two removed args in the config itself.
if no args are applied, itll just be the daemon, if args are applied it could do the following:
<REMOVED> -t {keyword} -> toggles the said hyprland keyword
-rc -> toggles refresh rate between two set values (set below)
-pc -> cycles power profiles
-t {device} -> changes the device detected for testing purposes

these next args should be after the ones mentioned above
if you add -m on the end it mutes the notification, and -l logs to console
'''

CHECK_INTERVAL = 3 #in seconds
USB_DEVICE = "TC Electronic GoXLR" # device checked through lsusb to detect if laptop is docked


MONITOR_NAME = "eDP-1"
MONITOR_REFRESH_RATES = [165.0,60.002] # for toggling between the two (first is default)
MONITOR_RESOLUTION = "2560x1600" #{} in place for the refresh rate, to be formatted later (same formatting as hyprland config file)

POWER_PROFILES = ["power-saver","balanced","performance"]

import subprocess, json, os, sys, time
from datetime import datetime

args = sys.argv

should_log = "-l" in args
should_notify = "-m" not in args

get_output = lambda command: subprocess.check_output(command, shell=True, text=True)
def notify(title, message):
    if should_notify:
        log(f'sending notif with title "{title}" and message "{message}"')
        os.system(f'notify-send -a "hypr" "{title}" "{message}"')
def log(message):
    if should_log:
        print(f"\x1b[93m{datetime.now().strftime('%H:%M:%S')}:\x1b[0m {message}")

def find_index(lst, value):
    try:
        return lst.index(value)
    except ValueError:
        return None

def confirm(message):
    log(f'confirming "{message}"')
    result = subprocess.run(
        f'rofi -dmenu -p "{message}"',
        shell=True, input="Yes\nNo", capture_output=True, text=True
    ).stdout.strip()
    return result == "Yes"

def get_docked():
    return USB_DEVICE in get_output("lsusb")

def get_locked():
    return "yes" in get_output("loginctl show-session $(loginctl show-user $(whoami) -p Display --value) -p LockedHint --value")

'''
# general keywords (for the daemon only animations:enabled is used)
class HyprKeyword:
    def __getitem__(self,keyword):
        lines = get_output(f"hyprctl getoption {keyword}").splitlines()
        return (lines[0][-1] == "1")
    def __setitem__(self,keyword, value):
        os.system(f"hyprctl keyword {keyword} \"{1 if value else 0}\"")
keywords = HyprKeyword()
'''

def get_animations():
    lines = get_output("hyprctl getoption animations:enabled").splitlines()
    return ("true" in lines[0])
def set_animations(value):
    os.system(f'hyprctl eval "hl.config({{animations={{enabled={str(value).lower()}}}}})" > /dev/null')

# power profiles (power-saver,balanced,performance)
def get_powerProfile():
    return get_output("powerprofilesctl get").replace("\n","")
def set_powerProfile(value):
    os.system(f"powerprofilesctl set {value}")

# display refresh rate, generally between 60 and 165 for my device (framework 16)
def get_refreshRate():
    monitors = json.loads(get_output("hyprctl monitors -j"))
    for monitor in monitors:
        if monitor["name"] == MONITOR_NAME:
            return monitor["refreshRate"]
def set_refreshRate(value):
    os.system(f'hyprctl eval \'hl.monitor({{output = "{MONITOR_NAME}",mode = "{MONITOR_RESOLUTION}@{value}Hz"}})\' > /dev/null')

r'''
# volume and mute settings
def get_volume():
    match = re.search(r"(\d+)%", get_output("pactl get-sink-volume @DEFAULT_SINK@"))
    volume = int(match.group(1)) if match else None
    muted = True if "yes" in get_output("pactl get-sink-mute @DEFAULT_SINK@") else False
    return(volume, muted)
def set_volume(volume,muted):
    os.system(f"pactl set-sink-volume @DEFAULT_SINK@ {volume}%")
    os.system(f"pactl set-sink-mute @DEFAULT_SINK@ {1 if muted else 0}")
'''

# brightness settings
def get_brightness():
    brightness = int(get_output("brightnessctl g 2>/dev/null").split(".")[-1])
    max = int(get_output("brightnessctl m 2>/dev/null"))
    return (brightness/max)*100
def set_brightness(value):
    os.system(f"brightnessctl -q s {value}% 2>/dev/null")

class SettingsProfile:
    def __init__(self):
        self.get_current()

    def get_current(self):
        self.powerProfile = get_powerProfile()
        self.refreshRate = get_refreshRate()
        self.animations = get_animations()
        #self.volume, self.volume_mute = get_volume()
        self.brightness = get_brightness()
        log(f"""fetched current values:
            power profile: {self.powerProfile}
            refresh rate: {self.refreshRate}
            animations: {self.animations}
            brightness: {self.brightness}""")

    def apply_values(self):
        set_powerProfile(self.powerProfile)
        set_refreshRate(self.refreshRate)
        set_animations(self.animations)
        set_brightness(self.brightness)
        log(f"""applied current values:
            power profile: {self.powerProfile}
            refresh rate: {self.refreshRate}
            animations: {self.animations}
            brightness: {self.brightness}""")

    def save_settings(self, path):
        with open(path, "w") as f:
            json.dump({
                "powerProfile": self.powerProfile,
                "refreshRate": self.refreshRate,
                "animations": self.animations,
                "brightness": self.brightness,
            }, f)
        log(f"Saved {path}")

    def load_settings(self, path):
        with open(path, "r") as f:
            values = json.load(f)
        self.powerProfile = values["powerProfile"]
        self.refreshRate = values["refreshRate"]
        self.animations = values["animations"]
        self.brightness = values["brightness"]
        log(f"Loaded {path}")

if __name__ == "__main__":
    '''
    if len(args) > 1 and args[1] == "-t":
        keywords[args[2]] = not keywords[args[2]]
        if should_notify: notify("Keyword changed",f"{args[2]}: {keywords[args[2]]}")
    '''
    if len(args) > 1 and args[1] == "-rc":
        print(get_refreshRate())
        id = find_index(MONITOR_REFRESH_RATES,get_refreshRate())
        if id is not None:
            new_rate = MONITOR_REFRESH_RATES[(id + 1) % len(MONITOR_REFRESH_RATES)] #cycle to the next id + wrap around
            set_refreshRate(new_rate)
            notify("refresh rate changed", f"set refresh rate to {int(new_rate)}")
        else:
            new_rate = MONITOR_REFRESH_RATES[0]
            set_refreshRate(new_rate)
            if should_notify: notify("refresh rate changed", f"set default refresh rate ({int(new_rate)})")
    elif len(args) > 1 and args[1] == "-pc":
        id = find_index(POWER_PROFILES,get_powerProfile())
        if id is not None:
            new_profile = POWER_PROFILES[(id+1) % len(POWER_PROFILES)] # cycle power profiles + wrap around
            set_powerProfile((new_profile))
            if should_notify: notify("Power profile changed",f"set profile to: {new_profile}")
    else: # main daemon
        if "-t" in args:
            USB_DEVICE = args[2]
        script_dir = os.path.dirname(os.path.abspath(__file__))
        if not os.path.exists(script_dir+"/live"):
            os.mkdir(script_dir+"/live")

        profile = SettingsProfile()
        other_profile = SettingsProfile()

        docked_config = script_dir+"/live/settings_changer_daemon_d.json"
        undocked_config = script_dir+"/live/settings_changer_daemon_u.json"

        if not os.path.exists(docked_config):
            profile.save_settings(docked_config)
        if not os.path.exists(undocked_config):
            profile.save_settings(undocked_config)

        docked = get_docked()
        ignore_next = False

        notify("Docked profile", "enabled profile: "+ ("Docked" if docked else "Portable"))
        log(f"loading values and applying, docked: {docked}")
        profile.load_settings(docked_config if docked else undocked_config)
        profile.apply_values()

        while True:
            time.sleep(CHECK_INTERVAL)
            if docked != get_docked():
                docked = not docked
                log(f"docked changed! now: {docked}")
                if ignore_next: ignore_next = False
                else:
                    was_locked = 0
                    while get_locked():
                        time.sleep(CHECK_INTERVAL)
                        was_locked = 3
                    time.sleep(was_locked)
                    if confirm("Switch to {} profile?".format("Docked" if docked else "Portable")): # TODO
                        if docked == get_docked(): # make sure nothing has changed since asked user
                            old_config = undocked_config if docked else docked_config
                            new_config = docked_config if docked else undocked_config

                            # make sure they are up to date
                            other_profile.load_settings(new_config)
                            profile.get_current()
                            #switcch em around
                            other_profile, profile = profile, other_profile
                            profile.apply_values()
                            other_profile.save_settings(old_config)
                            notify("Docked profile", "switched to profile: "+ ("Docked" if docked else "Portable"))
                            log(f"switched profiles, now: {docked}")
                        else:
                            docked = get_docked()
                            notify("Docked profile", "Skipped swithcing profiles.")
                    else:
                        ignore_next = True
                        log("user said no, ignoring next dock as well.")
