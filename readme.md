# Media Server Installation with Gdrive as your Source

Setup Includes:  Plex, Emby, Jelyfin - with Rclone Mount

## Pre Requisite
- Ubuntu VPS with Sudo Access
- Open Ports 32400, 8096 in your VPS
- Google Drive Full of contents to Stream

## Installation
- Clone the Repo and run the bash script
```
git clone https://github.com/roshanconnor123/mediaserver && sh mediaserver/install.sh
```
![mediaserver](https://i.ibb.co/ygKr9gG/Screenshot-1041.png)
- Choose Media server of you choice..Setup a new Rclone remote when it asks you to
- Once everything is done..Open Browser in your Computer (The Computer in which you are using your SSH client)
- Go to http://server.local.ip.address:32400/web - For Plex
- Go to http://server.local.ip.address:8096 - For Emby/Jellyfin
