echo "start jar"
echo "1. Get green image"
sudo docker-compose pull green

echo "2. Green container up"
sudo docker-compose up -d green

echo "3. Reload nginx"
sudo cp /etc/nginx/nginx.green.conf /etc/nginx/nginx.conf
sudo nginx -s reload
