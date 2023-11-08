# AstroColonyServerScript
Repository for the Astro Colony dedicated server

This documentation is currently being written and will be updated soon.

here's a quick startup guide in the meantime so you get a baseline :
this script was only tested on debian 11/12 and Ubuntu 22.04.3LTS

For this to work, you'll need to install tar unzip lib32gcc-s1 (as root)
`apt install tar unzip lib32gcc-s1 -y`

now create a new user (username : steam is enough, as long as it's not root)
once this is done, download the script and give yourself the execute permissions
`wget https://raw.githubusercontent.com/FuriosIra/AstroColonyServerScript/main/InstallAstroColonyLinuxServer.sh && chmod +x InstallAstroColonyLinuxServer.sh`
now run the installer
`./InstallAstroColonyLinuxServer.sh`
answer the questions with the settings you'd like
there will be some minor errors in the script, but as long as it dont crash everything is fine

# Dont forget to open your server's Query Port (default : 27015) on your firewall AND router or your server will not be accessible

Once this is all done, start your server by going in the ~/LinuxServer folder, and executing `./StartACServer.sh`
in your game, go to Multiplayer, Dedicated Server, find your server name, click join, type your password if you have, and there you go
**Streamer note : the server password will be displayed as plain text as of writing this, don't forget to hide it**

If you get kicked by the server when you join, try restarting it
if this doesn't fix it, your client and the server does not have the same version - verify which one you need to update (most likely the server) and update it
note that this script only works with installation, we did not test it to update your server and don't recommend you doing this, for more help, get in the Astro Colony's discord server : https://discord.com/invite/EFzAA3w
