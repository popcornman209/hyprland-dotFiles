#!/bin/python

OUTPUT_PATH = "/home/leo/Music/OnTheSpotToRockbox/"
OTS_DOWNLOAD_PATH = "/home/leo/Music/OnTheSpot/"
OTS_PATH = "/home/leo/Documents/programs/onthespot/"
IPOD_PATH = "/run/media/leo/IPOD/"

import webbrowser, os, re, subprocess, time

def sanitize_fat32(name):
    return re.sub(r'[\\/:*?"<>|]', "_", name).rstrip(" .")

def sanitize_fat32_path(path):
    return "/".join([sanitize_fat32(part) for part in path.split("/")])

def convert_mp3(path):
    output_dir = sanitize_fat32_path(os.path.dirname(OUTPUT_PATH + "Music/" + path.split("/Tracks/")[-1].strip()))
    output_mp3 = os.path.join(output_dir, sanitize_fat32(path.split("/")[-1]))
    art_path = os.path.join(output_dir, "cover.jpg")

    os.makedirs(output_dir, exist_ok=True)

    if not os.path.exists(output_mp3):
        print("Copying: "+path)
        subprocess.run(
            ["ffmpeg", "-y", "-i", path, "-vn", "-c:a", "copy", output_mp3],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
    if not os.path.exists(art_path):
        print("Creating album art: "+art_path)
        png = subprocess.run(
            [
                "ffmpeg",
                "-y",
                "-i",
                path,
                "-an",
                "-vf",
                "crop='min(iw,ih)':'min(iw,ih)',scale=500:500",
                "-f",
                "image2",
                "-vcodec",
                "png",
                "-frames:v",
                "1",
                "pipe:1",
            ],
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
        ).stdout
        subprocess.run(
            ["cjpeg", "-quality", "95", "-sample", "1x1", "-outfile", art_path],
            input=png,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )

def convert_m3u(name):
    with open(OTS_DOWNLOAD_PATH+"M3U/"+name, "r") as f:
        contents = f.readlines()

    mp3_files = []
    for i in range(len(contents)):
        if "/Tracks/" in contents[i]:
            mp3_files.append(contents[i].strip())
            rel_path = sanitize_fat32_path(contents[i].split("/Tracks/")[-1].strip())
            contents[i] = "/Music/" + rel_path + "\n"

    os.makedirs(os.path.join(OUTPUT_PATH, "Playlists"), exist_ok=True)

    with open(OUTPUT_PATH+"Playlists/"+name, "w") as f:
        f.write("".join(contents))

    return mp3_files

def wait_for_ipod():
    mount_point = IPOD_PATH.rstrip("/")
    print("Waiting for IPod...")
    while not os.path.ismount(mount_point):
        time.sleep(2)
    # mount can register before the filesystem is actually browsable, so
    # confirm it's readable before handing off to rsync
    while True:
        try:
            os.listdir(mount_point)
            break
        except OSError:
            time.sleep(1)
    print("IPod ready.")

while True:
    option = input("""1: Open tunemymusic spotify -> youtube converter
2: open youtube music
3: open OnTheSpot
4: convert entire OnTheSpot output to ipod
5: convert specific playlist to ipod
6: sync converted folder to IPod
pick option: """)
    if option == "1":
        webbrowser.open('https://www.tunemymusic.com/transfer/spotify-to-youtube-music')
    elif option == "2":
        webbrowser.open('https://music.youtube.com/library/playlists')
    elif option == "3":
        os.system(f"PYTHONPATH={OTS_PATH}src {OTS_PATH}venv/bin/python -m onthespot.gui")
    elif option == "4":
        m3u_files = [f for f in os.listdir(OTS_DOWNLOAD_PATH+"M3U/") if not f.startswith("Album - ")]
        for file in m3u_files:
            print(f"converting: {file}")
            convert_m3u(file)
        tracks_dir = OTS_DOWNLOAD_PATH + "Tracks/"
        for root, _, files in os.walk(tracks_dir):
            for file in files:
                if file.lower().endswith(".mp3"):
                    convert_mp3(os.path.join(root, file))
        print(f"Complete! transfer all files from {OUTPUT_PATH} into your ipods root directory!")
    elif option == "5":
        m3u_files = os.listdir(OTS_DOWNLOAD_PATH+"M3U/")
        for i, file in enumerate(m3u_files):
            print(f"{i+1}: {file}")
        m3u_file = m3u_files[int(input("Pick M3U file to convert: "))-1]
        mp3_files = convert_m3u(m3u_file)
        for file in mp3_files:
            convert_mp3(file)
        print(f"Complete! transfer all files from {OUTPUT_PATH} into your ipods root directory!")
    elif option == "6":
        wait_for_ipod()
        print("Copying new music...")
        subprocess.run(["rsync", "-rv", "--size-only", OUTPUT_PATH + "Music/", IPOD_PATH + "Music/"])
        print("Replacing playlists...")
        subprocess.run(["rsync", "-rtv", "--delete", OUTPUT_PATH + "Playlists/", IPOD_PATH + "Playlists/"])
        print("Sync complete!")
    else:
        print("quitting...")
        break
