[Installing MySQL on linux documentation](https://dev.mysql.com/doc/mysql-installation-excerpt/8.0/en/linux-installation.html)
> File names might not be accurate as new versions are released
# Download the repository
`wget https://dev.mysql.com/get/mysql-apt-config_0.8.23-1_all.deb`

# Install the repository
`sudo dpkg -i mysql-apt-config_0.8.23-1_all.deb`
> You will be prompted to choose the version - use the defaults

# Update package information
`sudo apt-get update`

# Install mysql server
`sudo apt-get install mysql-server`
> You will be prompted to choose a password for root@localhost

# Access the newly installed mysql server
`mysql -u root -p`