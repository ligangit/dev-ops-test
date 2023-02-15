FROM registry.cn-beijing.aliyuncs.com/hub-mirrors/openjdk:8-jdk-alpine
COPY target/dev-ops-test.jar app.jar

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]