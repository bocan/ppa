
#
# This is a work in progress...
#

## GOLD and Working:
apt install apt-utils devscripts debsigs
debsign *changes
debsigs --sign=origin  *deb

## TO BE DECIDED:
dpkg-scanpackages -a amd64 amd64  > Packages
dpkg-scansources amd64 > Sources

gzip -k -f Packages
gzip -k -f Sources

apt-ftparchive release . > Release

### Setup GPG
#gpg --import ../public-key.asc
#gpg --import ../private-key.asc

# Options for GPG password
# gpg --batch --pinentry-mode loopback --passphrase WHATEVER -abs -o b.gpg  b
#        --passphrase-file file

KEYNAME="chris@funderburg.me"
rm -fr Release.gpg; gpg --default-key ${KEYNAME} -abs -o Release.gpg Release
rm -fr InRelease; gpg --default-key ${KEYNAME} --clearsign -o InRelease Release


    curl -sSfL https://bocan.github.io/ppa/KEY.gpg | gpg --dearmor >/etc/apt/trusted.gpg.d/rspamd.gpg
    echo \
      "deb [signed-by=/etc/apt/trusted.gpg.d/rspamd.gpg] https://bocan.github.io/ppa/ ./" \
      >/etc/apt/sources.list.d/rspamd.list
