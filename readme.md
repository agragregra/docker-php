# Docker PHP MySQL phpMyAdmin
A lightweight Docker Compose setup for running a PHP application with MySQL (MySQLi & PDO) and phpMyAdmin.

## Clone
```
git clone https://github.com/agragregra/dpmp .; rm -rf trunk readme.md .gitignore .git
```

## Features
- **PHP**: Stable PHP version.
- **MySQL**: Stable MySQL version.
- **DB**: MySQLi & PDO.
- **phpMyAdmin**: Stable version, login: root / root.

## Server
  Files: www
  Host: http://localhost:8000
  phpMyAdmin: http://localhost:8080

## Service

1. docker up / down:
```
docker-compose up -d
docker-compose down

# first
sudo chmod -R 777 www && docker-compose up -d
```

2. export db
```
docker-compose exec db mysqldump -u root -proot opencart > backup.sql
```

3. import db
```
docker-compose exec -T db mysql -u root -proot opencart < backup.sql
```

4. remove all images & volumes:
```
docker system prune -a --volumes
```

## Troubleshooting NTFS /mnt Issues
If you encounter issues when using this setup with MySQL data stored on an NTFS partition (e.g., /mnt in WSL2), it may be due to permission or compatibility problems with the file system. Follow these steps to resolve them:

1. Edit the WSL configuration file:
```
sudo nano /etc/wsl.conf
```

2. Add the following section to configure automount options:
```
[automount]
options = "metadata,umask=0022"
```

3. Save the file and exit (Ctrl + X, Y, Enter), then restart WSL:
```
logout
wsl --shutdown
```

Note: This configuration ensures proper metadata handling and sets a umask of 0022 to align file permissions with WSL2 and MySQL requirements. After restarting, re-run your Docker Compose setup to verify the fix
