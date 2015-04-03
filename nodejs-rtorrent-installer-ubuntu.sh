# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

echo -e "$COL_RED ### Nwgat NodejS-rTorrent Installer ### $COL_RESET"
echo "This will install packages and create rtorrent user"
echo "Codename Exia"
echo ""
echo "Username (user@domain)"
read user
echo "Password"
read pw
echo "Origin ip or domain (no http!, sexy.ninja > http://sexy.ninja:3000)"
read host
echo ""
echo "please wait..."
apt-get update > /dev/null
apt-get install -y software-properties-common python-software-properties > /dev/null
add-apt-repository ppa:chris-lea/node.js -y > /dev/null
apt-get update > /dev/null
apt-get install -y python g++ make nodejs rtorrent git supervisor ufw > /dev/null

ufw allow 3000

echo ""
echo -e "$COL_YELLOW Packages Installed $COL_RESET"
echo ""

adduser --disabled-password --gecos "" rtorrent > /dev/null

mkdir /home/rtorrent/rtdl
echo "scgi_port = localhost:5000" >> /home/rtorrent/.rtorrent.rc
echo "directory = /home/rtorrent/rtdl" >> /home/rtorrent/.rtorrent.rc
echo "session = /home/rtorrent/.session/" >> /home/rtorrent/.rtorrent.rc
mkdir /home/rtorrent/.session/

echo ""
echo -e "$COL_YELLOW rTorrent Configured $COL_RESET"
echo ""

git clone https://github.com/roastlechon/nodejs-rtorrent.git /home/rtorrent/nodejs-rtorrent
mv /home/rtorrent/nodejs-rtorrent/config.json /home/rtorrent/nodejs-rtorrent/config.json.bak
cp nodejs-rtorrent-installer-config.json /home/rtorrent/nodejs-rtorrent/config.json
sed -i 's/userhost/'$host'/g' /home/rtorrent/nodejs-rtorrent/config.json
sed -i 's/useremail/'$user'/g' /home/rtorrent/nodejs-rtorrent/config.json
sed -i 's/userpass/'$pw'/g' /home/rtorrent/nodejs-rtorrent/config.json

chown -R rtorrent:rtorrent /home/rtorrent

su rtorrent -c "cd /home/rtorrent/nodejs-rtorrent && npm install"

echo ""
echo -e "$COL_YELLOW NodeJS-rTorrent Installed $COL_RESET"
echo ""

cp rtorrent.conf /etc/supervisor/conf.d/rtorrent.conf
cp njr.conf /etc/supervisor/conf.d/njr.conf
sed -i '/chmod=0700/a chown=rtorrent:rtorrent' /etc/supervisor/supervisord.conf

supervisorctl reload > /dev/null
echo -e "$COL_YELLOW Supervisor Configured $COL_RESET"
supervisorctl status

echo ""
echo "## > Login Details ##"
echo "URL: http://"$host":3000"
echo "User: "$user" Password: "$pw""
