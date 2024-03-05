FROM openjdk:11-jdk
# 변수 설정 (빌드 파일 경로)
ARG JAR_FILE=build/libs/sunflowerPlate-0.0.1-SNAPSHOT.jar
# 환경 변수 설정
ENV MARIADB_NAME=${MARIADB_NAME} \
MARIADB_PASSWORD=${MARIADB_PASSWORD} \
MARIADB_URL=${MARIADB_URL} \
MARIADB_USERNAME=${MARIADB_USERNAME} \
REFRESH-TOKEN-EXPIRY=${REFRESH-TOKEN-EXPIRY} \
REFRESH-TOKEN-SECRET=${REFRESH-TOKEN-SECRET} \
TOKEN-EXPIRY=${TOKEN-EXPIRY} \
TOKEN-SECRET=${TOKEN-SECRET} \
ACCESS-KEY=${ACCESS-KEY} \
SECRET-KEY=${SECRET-KEY} \
RESTAURANT-BUCKET=${RESTAURANT-BUCKET} \
REVIEW_IMG=${REVIEW_IMG} \
USER_BUCKET=${USER_BUCKET}
# 빌드 파일 컨테이너로 복사
COPY ${JAR_FILE} app.jar
# jar 파일 실행
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "/app.jar"]
