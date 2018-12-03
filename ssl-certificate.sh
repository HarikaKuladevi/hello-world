sudo yum install httpd httpd-manual openssl mod_ssl

cd /var/www/html/

sudo touch index.html

cd ~

ls -lZ /var/www/html/index.html

sudo systemctl restart httpd.service

sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload  

sudo mkdir /etc/ssl/private

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -subj "/C=US/ST=Illinois/L=Chicago/O=IIT-Company/OU=Org/CN=www.user.com"


echo " 
VirtualHost *:443>
ServerName localhost
DocumentRoot /var/www/html
SSLEngine on
SSLProtocol all -SSLv2 -SSLv3
SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5
SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>
<Directory "/var/www/html">
Require all granted
</Directory>" | sudo /etc/httpd/conf.d/sitel.conf

sudo systemctl restart httpd.service

