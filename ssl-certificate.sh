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

sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

cat /etc/ssl/certs/dhparam.pem | sudo tee -a /etc/ssl/certs/apache-selfsigned.crt

sudo cp /etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf.bak
sudo sed -i -e 's/#ServerName www.example.com:443/ServerName localhost/g' /etc/httpd/conf.d/ssl.conf
sudo sed -i -e 's/SSLCertificateKeyFile /etc/pki/tls/private/localhost.key/SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key/g' /etc/httpd/conf.d/ssl.conf
sudo sed -i -e 's/SSLCertificateFile /etc/pki/tls/certs/localhost.crt/SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt/g' /etc/httpd/conf.d/ssl.conf

sudo apachectl configtest

sudo systemctl restart httpd.service

