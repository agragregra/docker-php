# Docker PHP MySQL phpMyAdmin

A lightweight Docker Compose setup for running a PHP application with MySQL (MySQLi & PDO) and phpMyAdmin.

```
git clone https://github.com/agragregra/dpmp .; rm -rf trunk readme.md .gitignore .git
```

## Features

- **PHP**: Stable PHP version.
- **MySQL**: Stable MySQL version.
- **DB**: MySQLi & PDO.
- **phpMyAdmin**: Stable version, login: root / root.

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

## Service

1. build:
```
docker-compose build
```

2. docker up:
```
docker-compose up -d
```

3. docker down & remove db:
```
docker-compose down && sudo rm -rf ./data
```

4. remove all images & volumes:
```
docker system prune -a --volumes
```
