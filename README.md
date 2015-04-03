# nodejs-rtorrent-installer
Installer for nodejs-rtorrent

* Requires root
* Recommended for VPS/VMs
* it will NOT distroy you files, as there is no remove/delete command in the script, but still use a VPS/VMs to test please

# Install
* `git clone https://github.com/nwgat/nodejs-rtorrent-installer.git && cd nodejs-rtorrent-installer`
* `chmod +x nodejs-rtorrent-installer-ubuntu.sh && ./nodejs-rtorrent-installer-ubuntu.sh`
* then follow the on screen instructions

# Tip:
* if you want access to files from /home/rtorrent/rtdl
* login with `su rtorrent` and type `passwd` to set your own password
* then you can use port 22 in filezilla, xftp, smartftp, etc or use the highly recommended lftp utility
