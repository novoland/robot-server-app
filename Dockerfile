# 使用包含Maven的官方Java镜像
FROM maven:3.6.3-jdk-11 as builder
# 将工作目录设置为/app
WORKDIR /app
# 将你的源代码复制到镜像内的/app目录
COPY . .
# 触发Maven构建，这里假设是一个典型的Spring Boot项目
RUN mvn clean package -DskipTests

FROM openjdk:11-jre-slim
WORKDIR /app
VOLUME /tmp
COPY --from=builder /app/target/*.jar ./app.jar
EXPOSE 8000
CMD ["java","-jar","app.jar"]
