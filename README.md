** connect to db
mysql -h 127.0.0.1 -P 3307 -u nextcloud -p --ssl=0

** change domain
vi nginx/conf.d/nextcloud.conf
sudo vi ./appdata/www/nextcloud/config/config.php
change tunnel config in cloud flare

