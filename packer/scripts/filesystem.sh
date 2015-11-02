#
# Enable Filesystem Options
# - ACL's
# - Discard Flag (Might Make VM Disks More Compact)
# - /tmp on TMPFS
#
sed --in-place -e 's/\(.*swap.*sw\)/\1,discard/' /etc/fstab
sed --in-place -e 's/\(.*ext[34].*defaults\)/\1.acl,discard/' /etc/fstab

# This is Not Useable Where /tmp May Grow Above 512M
# echo "tmpfs /tmp tmpfs defaults,noatime,nodev,mode=1777,size=512M 0 0" >> /etc/fstab
# rm -rf /tmp/*
# mount /tmp
