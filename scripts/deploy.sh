#1
docker build --tag taeming/sunflowerplate -f /home/ec2-user/app/Dockerfile /home/ec2-user/app/;
docker push taeming/sunflowerplate:latest

EXIST_BLUE=$('docker-compose' -p sunflowerplate-blue -f /home/ec2-user/app/docker-compose.blue.yml ps | grep Up)

if [ -z "$EXIST_BLUE" ]; then
    docker-compose -p sunflowerplate-blue -f /home/ec2-user/app/docker-compose.blue.yml up -d
    BEFORE_COLOR="green"
    AFTER_COLOR="blue"
    BEFORE_PORT=8081
    AFTER_PORT=8080
else
    docker-compose -p sunflowerplate-green -f /home/ec2-user/app/docker-compose.green.yml up -d
    BEFORE_COLOR="blue"
    AFTER_COLOR="green"
    BEFORE_PORT=8080
    AFTER_PORT=8081
fi

echo "${AFTER_COLOR} server up(port:${AFTER_PORT})"

## 2
#for cnt in {1..10}
#do
#    echo "서버 응답 확인중(${cnt}/10)";
#    UP=$(curl -s http://localhost:${AFTER_PORT}/api/check)
#    if [ -z "${UP}" ]
#        then
#            sleep 10
#            continue
#        else
#            break
#    fi
#done
#
#if [ $cnt -eq 10 ]
#then
#    echo "서버가 정상적으로 구동되지 않았습니다."
#    exit 1
#fi

# 3
sudo sed -i "s/${BEFORE_PORT}/${AFTER_PORT}/" /etc/nginx/conf.d/service-url.inc
sudo nginx -s reload
echo "Deploy Completed!!"

# 4
echo "$BEFORE_COLOR server down(port:${BEFORE_PORT})"
docker-compose -p sunflowerplate-${BEFORE_COLOR} -f /home/ec2-user/app/docker-compose.${BEFORE_COLOR}.yml down