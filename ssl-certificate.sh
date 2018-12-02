sudo yum install httpd httpd-manual openssl mod_ssl

cd /var/www/html/

sudo touch index.html

cd ~

ls -lZ /var/www/html/index.html

sudo systemctl restart httpd.service

sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload  

sudo echo "#!/bin/bash" | sudo tee -a -i /usr/local/bin/apache_ssl
sudo echo "sudo mkdir /etc/httpd/ssl" | sudo tee -a -i /usr/local/bin/apache_ssl
sudo echo "sudo cd /etc/httpd/ssl" | sudo tee -a -i /usr/local/bin/apache_ssl
sudo echo "echo -e "Enter your virtual host FQDN: \n"" | sudo tee -a -i /usr/local/bin/apache_ssl
sudo echo "read cert" | sudo tee -a -i /usr/local/bin/apache_ssl
sudo echo "sudo openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out $cert.key" | sudo tee -a -i /usr/local/bin/apache_ssl
sudo echo "sudo chmod 600 $cert.key" | sudo tee -a -i /usr/local/bin/apache_ssl
sudo echo "sudo openssl req -new -key $cert.key -out $cert.csr" | sudo tee -a -i /usr/local/bin/apache_ssl
sudo echo "sudo openssl x509 -req -days 365 -in $cert.csr -signkey $cert.key -out $cert.crt" | sudo tee -a -i /usr/local/bin/apache_ssl
sudo echo "echo -e " The Certificate and Key file for $cert has been generated!\n"" | sudo tee -a -i /usr/local/bin/apache_ssl
sudo echo "ls -la /etc/httpd/ssl" | sudo tee -a -i /usr/local/bin/apache_ssl
sudo echo "exit 0" | sudo tee -a -i /usr/local/bin/apache_ssl


sudo chmod +x /usr/local/bin/apache_ssl

apache_ssl

echo apachecert

"certificates": [
  {
    "Country Name (2 letter code) [XX]" : "US",
    "State or Province Name (full name) []" : "Illinois",
    "Locality Name (eg, city) [Default City]" : "Chicago"
	"Organization Name (eg, company) [Default Company Ltd]" : "IIT"
	"Organizational Unit Name (eg, section) []" : "IIT"
	"Common Name (eg, your name or your server's hostname) []" : "user"
	"Email Address []" : "user@ao.com"
	"A challenge password []" : " "
	"An optional company name []" : " "
  }
],

sudo echo "<VirtualHost *:443>" | sudo tee -a -i /etc/httpd/conf.d/sitel.conf
sudo echo "ServerName localhost" | sudo tee -a -i /etc/httpd/conf.d/sitel.conf
sudo echo "DocumentRoot /var/www/html" | sudo tee -a -i /etc/httpd/conf.d/sitel.conf
sudo echo "SSLEngine on" | sudo tee -a -i /etc/httpd/conf.d/sitel.conf
sudo echo "SSLProtocol all -SSLv2 -SSLv3" | sudo tee -a -i /etc/httpd/conf.d/sitel.conf
sudo echo "SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5" | sudo tee -a -i /etc/httpd/conf.d/sitel.conf
sudo echo "SSLCertificateFile /etc/httpd/ssl/apachecert.crt" | sudo tee -a -i /etc/httpd/conf.d/sitel.conf
sudo echo "SSLCertificateKeyFile /etc/httpd/ssl/apachecert.key" | sudo tee -a -i /etc/httpd/conf.d/sitel.conf
sudo echo "</VirtualHost>" | sudo tee -a -i /etc/httpd/conf.d/sitel.conf
sudo echo "<Directory "/var/www/html">" | sudo tee -a -i /etc/httpd/conf.d/sitel.conf
sudo echo "Require all granted" | sudo tee -a -i /etc/httpd/conf.d/sitel.conf
sudo echo "</Directory>" | sudo tee -a -i /etc/httpd/conf.d/sitel.conf

sudo systemctl restart httpd.service

