# **Nextcloud Setup Notes**

## **1. Install Apps**
```
bash setup.sh
```

---

## **2. Connect to Database**
```
mysql -h 127.0.0.1 -P 3307 -u nextcloud -p --ssl=0
```

---

## **3. Nextcloud Config Path**
```
mkdir -p appdata/www/nextcloud/config/
```

Main config file:
```
appdata/www/nextcloud/config/config.php
```

---

## **4. Change Domain**
- Edit Nginx config: (not necessary no additional nginx)  
  ```
  vi nginx/conf.d/nextcloud.conf
  ```
- Edit Nextcloud config:  
  ```
  sudo vi ./appdata/www/nextcloud/config/config.php
  ```
- Update Cloudflare Tunnel configuration.

---

# **Backup Checklist**
- Pi-hole folder (copy directly)
- All `.env` files  
- TLS certificates stored in Cloudflare folder  (optional no ngnix)
- `./appdata/www/nextcloud/config/config.php`  
- Database backup using:
  ```
  mysqldump ...
  ```

---

# **Useful Commands**

## **List Installed Apps**
```
find / -name occ
cd /app/www/public/
php /app/www/public/occ app:list
```

---

## **After Editing `config.php`**
```
php occ maintenance:update:htaccess
```

---

## **Connect to Database Again**
```
mysql -h 127.0.0.1 -P 3307 -u nextcloud -p --ssl=0
```

