#1. Backup the /var/run:

mv /var/run /var/run.old
mv /var/lock /var/lock.old

#2. Recreate the symbolic link:

ln -s /run /var/
ln -s /run/lock /var/

#4. Verify if the link has been created:

ls -l /var/run
ls -l /var/lock


# 5. Sync the changes:

sync; sync

#6. Restart the server:

reboot
