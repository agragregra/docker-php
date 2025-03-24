# Docker PHP MySQL phpMyAdmin
Docker configuration for running PHP application with MySQL (MySQLi/PDO) and phpMyAdmin.

## Clone
```
git clone https://github.com/agragregra/dphp .; rm -rf trunk .gitignore .git
```

## Features
- **PHP**: Stable PHP version.
- **MySQL**: Stable MySQL/MariaDB version.
- **DB**: MySQLi & PDO.
- **phpMyAdmin**: Stable version.
- **Composer**.

## Server
  - app: www
  - public: www/public_html
  - http: http://localhost:8000
  - https: https://localhost:8443
  - phpMyAdmin: http://localhost:8080 (root:root & user:user)

## Service

* ./run.sh args
```
chmod +x ./run.sh
Usage: ./run.sh { up | down | bash | prune | deploy | backup | clear }
```

* docker up / down:
```
# first
sudo chmod -R 777 . && docker-compose up -d

docker-compose up -d
docker-compose down
```

* internal bash:
```
docker-compose exec web bash
exit
```

* export db
```
docker-compose exec db mysqldump -u root -proot example > backup.sql
```

* import db
```
docker-compose exec -T db mysql -u root -proot example < backup.sql
```

* remove all images & volumes:
```
docker system prune -af --volumes
```

## Troubleshooting NTFS /mnt Issues
If you encounter issues when using this setup with MySQL data stored on an NTFS partition (e.g., /mnt in WSL2), it may be due to permission or compatibility problems with the file system. Follow these steps to resolve them:

1. Adding the [automount] block to /etc/wsl.conf
```
grep -q "\[automount\]" /etc/wsl.conf || echo -e "\n[automount]\noptions=\"metadata,umask=0022\"" | sudo tee -a /etc/wsl.conf
```

2. Then restart WSL:
```
logout
wsl --shutdown
```

Note: This configuration ensures proper metadata handling and sets a umask of 0022 to align file permissions with WSL2 and MySQL requirements. After restarting, re-run your Docker Compose setup to verify the fix
