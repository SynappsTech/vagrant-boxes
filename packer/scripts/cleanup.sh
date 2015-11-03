#!/bin/bash -eux

# Clean Up
apt-get -y --purge remove linux-headers-$(uname -r) build-essential
apt-get -y --purge autoremove
apt-get -y purge $(dpkg --list |grep '^rc' |awk '{print $2}')
apt-get -y purge $(dpkg --list |egrep 'linux-image-[0-9]' |awk '{print $3,$2}' |sort -nr |tail -n +2 |grep -v $(uname -r) |awk '{ print $2}')
apt-get -y clean

find /var/lib/apt/lists \! -name lock -type f -delete

# Delete Linux Source
dpkg --list | awk '{ print $2 }' | grep linux-source | xargs apt-get -y purge

# Delete Development Packages
dpkg --list | awk '{ print $2 }' | grep -- '-devs$' | xargs apt-get -y purge

# Delete Compilers and Other Development Tools
apt-get -y purge cpp gcc g++

# Delete X11 Libraries
apt-get -y pruge libx11-data xauth libxmuu1 libxcb1 libx11-6 libxext6

# Delete Obsolete Networking
apt-get -y purge ppp pppconfig pppoeconf

# Delete Oddities
apt-get -y purge popularity-contest

# Cleanup Virtualbox
rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?

# Cleanup Chef
rm -f /tmp/chef*deb

# Remove Unused Locales
rm -rf /user/share/locale/{af,am,ar,as,ast,az,bal,be,bg,bn,bn_IN,br,bs,byn,ca,cr,cs,csb,cy,da,de,de_AT,dz,el,en_AU,en_CA,eo,es,et,et_EE,eu,fa,fi,fo,fr,fur,ga,gez,gl,gu,haw,he,hi,hr,hu,hy,id,is,it,ja,ka,kk,km,kn,ko,kok,ku,ky,lg,lt,lv,mg,mi,mk,ml,mn,mr,ms,mt,nb,ne,nl,nn,no,nso,oc,or,pa,pl,ps,pt,pt_BR,qu,ro,ru,rw,si,sk,sl,so,sq,sr,sr*latin,sv,sw,ta,te,th,ti,tig,tk,tl,tr,tt,ur,urd,ve,vi,wa,wal,wo,xh,zh,zh_HK,zh_CN,zh_TW,zu}

# Remove Docs
rm -rf /usr/share/doc

# Remove Files from Cache
find /var/cache -type f -delete -print

# Remove Guest Additions Source
rm -rf /usr/src/virtualbox-ose-guest*
rm -rf /usr/src/vboxguest*

# Remove Man Pages
rm -rf /usr/share/man/??
rm -rf /usr/share/man??_*

# Zero Out the Free Space to Save Space in the Final Image
echo "Zeroing device to make space..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Remove History File
unset HISTFILE
rm ~/.bash_history /home/vagrant/.bash_history

# Block Until the Empty File Has Been Removed, Otherwise, Packer Will Try To
# Kill the Box While the Disk is Still Full and That's Bad.
sync
