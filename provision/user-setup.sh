
# access rights for ssh keys
chmod 600 /home/*/.ssh/*

cp -p /home/vagrant/.workshopvm/user-settings.sh /etc/profile.d/user-settings.sh
cp -p /home/vagrant/.workshopvm/mod-bash.sh /etc/bash_completion.d/mod-bash.sh
