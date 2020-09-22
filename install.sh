#!/usr/bin/env bash
#=============================================================
# https://github.com/roshanconnor123/mediaserver
# File Name: install.sh
# Author: roshanconnor
# Description:一Installation of Media Servers
# System Required: Debian/Ubuntu
#=============================================================

COLOR="\033["
NORMAL="${COLOR}0m"
YELLOW="${COLOR}1;33m"
RED="${COLOR}1;31m"
CYAN="${COLOR}1;36m"
BLUE="${COLOR}1;34m"
GREEN="${COLOR}1;32m"
PURPLE="${COLOR}1;35m"

# ★★★Installation of Rclone and Creating a remote★★★
rclone() {
  curl https://rclone.org/install.sh | sudo bash
  sudo apt update && sudo apt install fuse
  sudo sed -i '/#user/s/#//g' /etc/fuse.conf
  sudo mkdir /mnt/media
  sudo rclone config
}
# ★★★Mounting using rclone★★★
mount() {
  echo "Provide your remote name you configured in rclone\n"
  read remote
  sudo rclone mount "$remote": /mnt/media --allow-other --allow-non-empty --vfs-cache-mode writes &
}
# ★★★cronjob for rclone mount★★★
cron() {
  echo "Provide your remote name you configured in rclone\n"
  read remote
  crontab -l > mycron
  echo "@reboot sudo rclone mount "$remote": /mnt/media --allow-other --allow-non-empty --vfs-cache-mode writes &" >> mycron
  #install new cron file
  crontab mycron
  rm mycron
}  
# ★★★Installation of Plex★★★
plex () {
  sudo apt-get update
  sudo apt-get upgrade
  wget https://downloads.plex.tv/plex-media-server-new/1.20.1.3252-a78fef9a9/debian/plexmediaserver_1.20.1.3252-a78fef9a9_amd64.deb
  sudo dpkg -i plexmediaserver*.deb
  sudo systemctl enable plexmediaserver.service
  sudo systemctl start plexmediaserver.service
  echo "${BLUE}Plex has been Installed succesfully${NORMAL}"
  echo "${RED}Go to ip.adress.of.server:32400 in your browser now${MORMAL}"
}
# ★★★Installation of Emby★★★
emby() {
  sudo apt-get update
  sudo apt-get upgrade
  wget https://github.com/MediaBrowser/Emby.Releases/releases/download/4.4.3.0/emby-server-deb_4.4.3.0_arm64.deb
  sudo dpkg -i emby-server-*.deb
  sudo service emby-server start
  echo "${BLUE}Emby has been Installed succesfully${NORMAL}"
  echo "${RED}Go to ip.adress.of.server:8096 in your browser now${MORMAL}"
}
# ★★★Installation of Jellyfin★★★
jellyfin() {
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt install apt-transport-https
  sudo add-apt-repository universe
  wget -O - https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key | sudo apt-key add -
  sudo touch /etc/apt/sources.list.d/jellyfin.list
  echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/ubuntu $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list
  sudo apt update
  sudo apt install jellyfin
  echo "${BLUE}Jellyfin has been Installed succesfully${NORMAL}"
  echo "${RED}Go to ip.adress.of.server:8096 in your browser now${MORMAL}"
}

# ★★★Installation★★★
echo && echo " ${BLUE}Media Server Installation Srcipt${NORMAL} by ${RED}Roshanconnor${NORMAL}

➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
1.${GREEN}Installation Of Plex with Gdrive${NORMAL}
2.${GREEN}Installation Of Emby with Gdrive${NORMAL}
3.${GREEN}Installation Of Jellyfin with Gdrive${NORMAL}
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
69.${PURPLE}Exit${NORMAL}" && echo
read -p " Choose any Number [1-3]:" option

case "$option" in
1)
    rclone
	mount
	cron
	plex
	;;
2)
    rclone
    mount
	cron
    emby
	;;
3)
    rclone
    mount
	cron
    jellyfin	
    ;;	
69)
    exit
    ;;
*)
    echo
    echo " ${RED}Choose Correct Number from the Options${NORMAL}"
    ;;
esac 
  
