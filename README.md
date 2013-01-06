backup-scripts
==============

Bunch of scripts to backup online data

Backup Google Contacts
----------------------

backup_contacts.rb - Exports your Google Contacts into an XML file

	Usage: backup_gcontacts --username USERNAME --password PASSWORD OUTPUT_PATH
    		-u, --username USERNAME          Google username, use your full gmail address
    		-p, --password PASSWORD          Your password, used to perform the request (if you have two-factor authentication,and you should,just generate a new app password
    		-h, --help                       Display this screen

cron cmd example: /bin/bash -l -c 'cd /path/to/script  && bundle exec ruby backup-google-contacts.rb -u someuser@gmail.com -p youramazingpassword /path/to/backup/folder'
