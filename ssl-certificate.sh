sudo yum install httpd httpd-manual openssl mod_ssl

cd /var/www/html/

sudo touch index.html

cd ~

ls -lZ /var/www/html/index.html

sudo systemctl restart httpd.service

sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload  

echo "
#!/bin/bash
sudo mkdir /etc/httpd/ssl
sudo cd /etc/httpd/ssl
echo -e "Enter your virtual host FQDN: \n"
read cert
sudo openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out $cert.key
sudo chmod 600 $cert.key
sudo openssl req -new -key $cert.key -out $cert.csr
sudo openssl x509 -req -days 365 -in $cert.csr -signkey $cert.key -out $cert.crt
echo -e " The Certificate and Key file for $cert has been generated!\n"
ls -la /etc/httpd/ssl
exit 0" | sudo /usr/local/bin/apache_ssl


sudo chmod +x /usr/local/bin/apache_ssl

apache_ssl

echo " 
VirtualHost *:443>
ServerName localhost
DocumentRoot /var/www/html
SSLEngine on
SSLProtocol all -SSLv2 -SSLv3
SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5
SSLCertificateFile /etc/httpd/ssl/apachecert.crt
SSLCertificateKeyFile /etc/httpd/ssl/apachecert.key
</VirtualHost>

<Directory "/var/www/html">
Require all granted
</Directory>" | sudo /etc/httpd/conf.d/sitel.conf

sudo systemctl restart httpd.service

