#!/bin/python
'''
this isn't meant to be fast or good, its not, just making a quick script for generating the font i use in my configs
cant find the old website i used, managed to find this one, but id prefer to just have a script or keybind for it than need a browser

-r -> through rofi (saves output to clipboard)
-i <string> -> custom input (unless -r is present)
'''

chars = "abcdefghijklmnopqrstuvwxyz -!.:1234567890"

lines_seperated = [[
    ['▄▀█', '█▄▄', '█▀▀', '█▀▄', '█▀▀', '█▀▀', '█▀▀', '█ █', '█', '  █', '█▄▀', '█  ', '█▀▄▀█'],
    ['█▀█', '█▄█', '█▄▄', '█▄▀', '█🬰🬭', '█▀ ', '█▄█', '█▀█', '█', '█▄█', '█ █', '█▄▄', '█ ▀ █']
],
[
    ['█▄ █', '█▀█', '█▀█', '█▀█', '█▀█', '█▀', '▀█▀', '█ █', '█ █', '█ █ █', '▀▄▀', '█▄█', '▀█'],
    ['█ ▀█', '█▄█', '█▀▀', '▀▀█', '█▀▄', '▄█', ' █ ', '█▄█', '▀▄▀', '▀▄▀▄▀', '█ █', ' █ ', '█▄']
],
[
    [' ', '  ','█', ' ', '▄', '▀█ ', '▀█', '▀▀█', '█ █', '█▀', '█▄▄', '▀█', '█🬰█', '█▀█', '█▀█'],
    [' ', '▀▀','▄', '▄', '▄', '▄█▄', '█▄', '🬭🬰█', '▀▀█', '▄█', '█▄█', '█ ', '█🬰█', '▀▀█', '█▄█']
],
[
    [' '], #gap between characters
    [' ']
]]

lines = [
    [],
    []
]
for line in lines_seperated:
    lines[0] += line[0]
    lines[1] += line[1]

import sys, subprocess

save_to_clipboard = False
if "-r" in sys.argv:
    save_to_clipboard = True
    #ai generated the below line btw
    input_text = subprocess.run(["rofi", "-dmenu", "-p", "Text:"], capture_output=True, text=True).stdout.strip()
elif "-i" in sys.argv:
    input_text = sys.argv[-1]
else:
    input_text = input("Text> ")

output1 = ""
output2 = ""
for letter in input_text.lower():
    if letter in chars:
        idx = chars.index(letter)
        output1 += lines[0][idx] + lines[0][-1]
        output2 += lines[1][idx] + lines[1][-1]

output1.rsplit(lines[0][-1])[0]
output2.rsplit(lines[1][-1])[0]

if save_to_clipboard:
    subprocess.run(["wl-copy"], input=output1+"\n"+output2, text=True)
else:
    print(output1)
    print(output2)
