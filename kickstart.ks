lang en_US.UTF-8
keyboard --xlayouts='us'
timezone America/Los_Angeles --isUtc
zerombr

###### Disk and Partitions ###########################
zerombr
#ignoredisk --only-use=nvme0n1
clearpart --all --initlabel
part /boot/efi --fstype=efi --size=512 --asprimary
part /boot --fstype=xfs --size=1024 --asprimary
part pv.01 --grow --fstype=xfs
volgroup rhel pv.01
logvol / --vgname=rhel --fstype=xfs --size=20000 --name=root

##############################################################
# Prep and kickoff ostree install
######################################################
reboot
text
network --bootproto=dhcp --device=link --activate --onboot=on

ostreesetup --nogpg --url="http://ec2-34-214-35-126.us-west-2.compute.amazonaws.com/rhde/repo" --osname=rhel --remote=edge --ref=rhel/9/x86_64/edge

##############################################################
# Post Install directives
######################################################
%post --log=/var/log/anaconda/post-install.log

echo -e 'url=http://ec2-35-92-139-83.us-west-2.compute.amazonaws.com/rhde/repo' >> /etc/ostree/remotes.d/edge.conf
%end