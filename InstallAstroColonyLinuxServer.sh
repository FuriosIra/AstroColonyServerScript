#!/bin/sh

# Copyright (c) 2023 FuriosIra
# Author: FuriosIra
# Helper: Kinton_Hiryuu
# https://github.com/FuriosIra/AstroColonyServerScript
# My Discord link : https://discord.gg/paS5eYF
# Astro Colony Discord link : https://discord.com/invite/EFzAA3w

serverFoldersLink="https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=172paqsE1eYO8U54BRCkP94rC_m-ovJD3' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=172paqsE1eYO8U54BRCkP94rC_m-ovJD3"

defaultServerName=`whoami`"'s Super Server"
defaultServerPassword=""
defaultServerPort="27015"
defaultServerAdminList=""
defaultServerMaxPlayers="5"
defaultServerSavegameName="AstroColony game"
defaultServerMapName="AstroColony game"
defaultServerSeed="7300"


echo "This script will install you everything you need to run a Linux Astro Colony Server."
echo "Please note that the linux version of the game's server is work in progress and subject to change, unstability and bugs will be encountered"
echo ""
echo "This script was tested on Debian 11, Debian 12, and Ubuntu 22.04.3 LTS. Feel free to tell us on github if you got it working elsewhere."
echo ""
echo ""
echo ""
echo "Please make sure you installed the following packages on your system :"
echo " - tar"
echo " - unzip"
echo " - lib32gcc-s1"
echo " - screen or tmux (optionnal)"
echo ""
echo "To make sure those are installed, exit this script by hitting CTRL+C and enter this command with admin privileges :"
echo "apt install tar unzip lib32gg-s1 -y"
echo "Once this is done, come back here and press enter"
read ready


clear
echo "Perfect, now that this is out of our way, we will need to prepare some settings for the server :"
echo "Most of these settings will be editable either in the startup file or in the settings file located in"
echo `pwd`"/LinuxServer/AstroColony/Saved/Config/LinuxServer/ServerSettings.ini"
echo ""
echo ""

echo "How do you want to name your server ? default : ${defaultServerName}"
read serverName
if [[ -z $serverName ]]
then 
	serverName=$defaultServerName
fi
echo "Your server name will be ${serverName}"
echo ""
echo ""

echo "Which password will be needed to connect ? Press enter for no password (security risk)"
read serverPassword
if [[ -z $serverPassword ]]
then 
	serverPassword=$defaultServerPassword
fi
echo "Your server password will be ${serverPassword}"
echo ""
echo ""

echo "Which port will be used to connect ? default : ${defaultServerPort} (recommended) must be within 1-65535"
read serverPort
if [[ -z $serverPort ]] && [[ $serverPort -ge 0 ]] && [[ 65536 -ge $serverPort  ]]
then 
	serverPort=$defaultServerPort
fi
echo "Your server password will be ${serverPort}"
echo ""
echo ""


echo "Add Admins to manage server once ingame (default : none)"
echo "This must be a list of steamid64 separated by commas : 76561198125852136,76561198262568532,76561198193923467"
echo "To get your steamid64, you may want to go on https://steamid.io"
read serverAdminList
if [[ -z $serverAdminList ]]
then 
	serverAdminList=$defaultServerAdminList
fi
echo "Registered Admins steamdid64 are ${serverAdminList}"
echo ""
echo ""

echo "How many players do you want maximum connected together on your server ? default : ${defaultServerMaxPlayers}"
read serverMaxPlayers
if [[ -z $serverMaxPlayers ]]
then 
	serverMaxPlayers=$defaultServerMaxPlayers
fi
echo "There will be maximum ${serverMaxPlayers} players online on your server"
echo ""
echo ""

echo "SavegameName setting skipped. Feel free to uncomment when this is working"
#echo "How do you want to name your save file ? default : ${defaultServerSavegameName}"
#read serverSavegameName
#if [[ -z $serverSavegameName ]]
#then 
	serverSavegameName=$defaultServerSavegameName
#fi
#echo "Your local savefile will be named ${serverSavegameName}"
echo ""
echo ""

echo "How do you want to name your save file in the server list ? default : ${defaultServerMapName}"
read serverMapName
if [[ -z $serverMapName ]]
then 
	serverMapName=$defaultServerMapName
fi
echo "${serverMapName} will be displayed as this server's map name"
echo ""
echo ""

echo "What seed will be used for generation ? default : ${defaultServerSeed}. Must be only number or it will default to 113"
read serverSeed
if [[ -z $serverSeed ]]
then 
	serverSeed=$defaultServerSeed
#astro colony seeds shinanigan, if the seed contain something else than number it will fallback to 113
elif [[ serverSeed =~ [^[:digit:]]  ]]; then
	echo "You entered a alphanumeric seed, unfortunately if the seed is not only number, it will be 113 whatever you try"
	serverSeed=113
fi
echo "Your default map's seed will be ${serverSeed}"
echo ""
echo ""

#settings recap
clear
echo "Here are the settings you just defined :"
echo "Server display name : ${serverName}"
echo "Server access password : ${serverPassword}"
echo "Server Port used (may need to be opened) : ${serverPort}/udp"
echo "Admin's steamid64 : ${serverAdminList}"
#echo "Save Game Name : ${savegameName}"
echo "Default world's seed : ${serverSeed}"
echo ""
echo "These settings will be editable later in the config files (check github and/or official discord server for help)"
echo "Is everything as you want it ? (Y/n)"
read installServer

if [[ $installServer != "y" ]] || [[ $installServer != "Y" ]]
then
	exit
fi

#Starting files download and installation
echo "Installing the server.........."

cd ~

echo "Downloading Astro Colony Dedicated Server"
wget --load-cookies /tmp/cookies.txt $serverFoldersLink -O AstroColonyLinuxServer.zip && rm -rf /tmp/cookies.txt

echo "Unzipping the files"
unzip AstroColonyLinuxServer.zip && chmod +x LinuxServer/AstroColonyServer.sh

echo "Downloading SteamCMD and dependances"
mkdir steamcmd && cd steamcmd
wget http://media.steampowered.com/client/steamcmd_linux.tar.gz && tar -xvzf steamcmd_linux.tar.gz 
./steamcmd.sh +force_install_dir ../libsdk +login anonymous +app_update 1007 +quit 

echo "Putting dependances where they should go"
cp ~/libsdk/linux64/steamclient.so ~/LinuxServer/AstroColony/Binaries/Linux/steamclient.so && cd ~

echo "Creating config file in" `pwd`"/LinuxServer/AstroColony/Saved/Config/LinuxServer/ServerSettings.ini"
mkdir -p LinuxServer/AstroColony/Saved/Config/LinuxServer && cd LinuxServer/AstroColony/Saved/Config/LinuxServer

echo '[/Script/AstroColony.EHServerSubsystem]' >> ServerSettings.ini
echo 'ServerPassword=${serverPassword}' >> ServerSettings.ini
echo 'MapName=${serverMapName}' >> ServerSettings.ini
echo 'Seed=${serverSeed}' >> ServerSettings.ini
echo 'MaxPlayers=${serverMaxPlayers}' >> ServerSettings.ini
echo 'SavegameName=${serverSavegameName}' >> ServerSettings.ini
echo 'ShouldLoadLatestSavegame=True' >> ServerSettings.ini
echo 'AdminList=${serverAdminList}' >> ServerSettings.ini
echo 'SharedTechnologies=True' >> ServerSettings.ini
echo 'OxygenConsumption=True' >> ServerSettings.ini
echo 'FreeConstruction=False' >> ServerSettings.ini
echo 'AutosaveInterval=5.0' >> ServerSettings.ini
echo 'AutosavesCount=10' >> ServerSettings.ini
cd ~/LinuxServer

echo '#!/bin/sh' >> StartACserver.sh
echo './AstroColonyServer.sh -QueryPort=27015 -SteamServerName="[ChangeMe]" -log' >> StartACserver.sh
chmod +x StartACserver.sh

cd ~
echo "";echo "";echo "";echo "";
echo "Installation complete "
echo "To run the server, go in the "`pwd`"/LinuxServer folder and run './StartACserver.sh'"
echo "For support, please join AstroColony's official discord server : https://discord.com/invite/EFzAA3w"
cd ~/LinuxServer