#!/bin/sh

# Copyright (c) 2023 FuriosIra
# Author: FuriosIra
# Helper: Kinton_Hiryuu
# https://github.com/FuriosIra/AstroColonyServerScript
# My Discord link : https://discord.gg/paS5eYF
# Astro Colony Discord link : https://discord.com/invite/EFzAA3w

echo "Download Astro Colony Dedicated Server"
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=172paqsE1eYO8U54BRCkP94rC_m-ovJD3' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=172paqsE1eYO8U54BRCkP94rC_m-ovJD3" -O AstroColonyLinuxServer.zip && rm -rf /tmp/cookies.txt

echo "Unzip Astro Colony Dedicated Server"
unzip AstroColonyLinuxServer.zip && chmod +x LinuxServer/AstroColonyServer.sh

echo "Download SteamCMD and copy Steam dependances"
mkdir steamcmd && cd steamcmd && wget http://media.steampowered.com/client/steamcmd_linux.tar.gz && tar -xvzf steamcmd_linux.tar.gz && ./steamcmd.sh +force_install_dir ../libsdk +login anonymous +app_update 1007 +quit && cp ~/libsdk/linux64/steamclient.so ~/LinuxServer/AstroColony/Binaries/Linux/steamclient.so && cd ~

echo "Add ConfigServer"
mkdir -p LinuxServer/AstroColony/Saved/Config/LinuxServer && cd LinuxServer/AstroColony/Saved/Config/LinuxServer
echo '[/Script/AstroColony.EHServerSubsystem]' >> ServerSettings.ini
echo 'ServerPassword=[ChangeMe]' >> ServerSettings.ini
echo 'MapName=[ChangeMe]' >> ServerSettings.ini
echo 'Seed=[ChangeMe]' >> ServerSettings.ini
echo 'MaxPlayers=10' >> ServerSettings.ini
echo 'SavegameName=[ChangeMe]' >> ServerSettings.ini
echo 'ShouldLoadLatestSavegame=True' >> ServerSettings.ini
echo 'AdminList=' >> ServerSettings.ini
echo 'SharedTechnologies=True' >> ServerSettings.ini
echo 'OxygenConsumption=False' >> ServerSettings.ini
echo 'FreeConstruction=False' >> ServerSettings.ini
echo 'AutosaveInterval=5.0' >> ServerSettings.ini
echo 'AutosavesCount=10' >> ServerSettings.ini
cd ~/LinuxServer

echo "Add custon StartServer"
echo '#!/bin/sh' >> StartACserver.sh
echo './AstroColonyServer.sh -QueryPort=27015 -SteamServerName="[ChangeMe]" -log' >> StartACserver.sh
chmod +x StartACserver.sh

echo "Install complete "
