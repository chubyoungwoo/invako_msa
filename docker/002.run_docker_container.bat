rem docker network create --subnet 192.168.0.0/24 --gateway 192.168.0.1 egov-network

docker run -d --rm --name discovery ^
       --network egov-network ^
       -e SPRING_PROFILES_ACTIVE=default ^
       -e EUREKA_INSTANCE_HOSTNAME=discovery ^
       -e TZ=Asia/Seoul ^
       -p 8761:8761 ^
       discovery:1.0


docker run -d --rm --name config ^
       --network egov-network ^
       -v c:/Users/cbw/workspace/egovframe-msa-edu/config:/usr/app/config ^
       -e SPRING_PROFILES_ACTIVE=native ^
       -e ENCRYPT_KEY=token_secret ^
       -e logstash_hostname=logstash:5001 ^
       -e SEARCH_LOCATION=file:///usr/app/config ^
       -e RABBITMQ_HOSTNAME=rabbitmq ^
       -e ZIPKIN_HOSTNAME=zipkin ^
       -e TZ=Asia/Seoul ^
       -p 8888:8888 ^
       config:1.0

docker run -d --rm --name apigateway ^
       --network egov-network ^
       -v c:/Users/cbw/workspace/msa-attach-volume:/usr/app/msa-attach-volume ^
       -e SPRING_CLOUD_CONFIG_URI=http://config:8888 ^
       -e SPRING_PROFILES_ACTIVE=default ^
       -e EUREKA_INSTANCE_HOSTNAME=discovery ^
       -e RABBITMQ_HOSTNAME=rabbitmq ^
       -e ZIPKIN_HOSTNAME=zipkin ^
       -e TOKEN_SECRET=egovframe ^
       -e APP_HOME=/usr/app ^
       -e TZ=Asia/Seoul ^
       -p 8000:8000 ^
       apigateway:1.0

docker run -d --rm --name user-service ^
       --network egov-network ^
       -e SPRING_CLOUD_CONFIG_URI=http://config:8888 ^
       -e SPRING_PROFILES_ACTIVE=dev ^
       -e MESSAGES_DIRECTORY=/usr/app/msa-attach-volume/messages ^
       -e APP_HOME=/usr/app ^
       -e logstash_hostname=logstash:5001 ^
       -e EUREKA_INSTANCE_HOSTNAME=discovery ^
       -e MYSQL_HOSTNAME=mysql ^
       -e RABBITMQ_HOSTNAME=rabbitmq ^
       -e ZIPKIN_HOSTNAME=zipkin ^
       -e TOKEN_SECRET=egovframe ^
       -e TZ=Asia/Seoul ^
       user-service:1.0

rem 1@gmail.com / test1234!
docker run -d --rm --name front-admin ^
       --network egov-network ^
       -p 3000:3000 ^
       frontend-admin:1.0