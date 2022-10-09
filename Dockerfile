FROM 39.108.3.126:3443/ahao/skywalking-8.7.0-jdk8:v1
WORKDIR /java

ARG APP_NAME="devops-project"
ARG JAR_FILE="target/${APP_NAME}.jar"
ARG DEFAULT_APP_ACTIVE_PROFILE
ARG DEFAULT_SKYWALKING_SERVER_ADDR
ARG DEFAULT_CONFIG_SERVER_ADDR

COPY ${JAR_FILE} /java/app.jar
ENV TZ="Asia/Shanghai" \
SKYWALKING_SERVER_ADDR=${DEFAULT_SKYWALKING_SERVER_ADDR} \
APP_ACTIVE_PROFILE=${DEFAULT_APP_ACTIVE_PROFILE} \
CONFIG_SERVER_ADDR=${DEFAULT_CONFIG_SERVER_ADDR} \
JVM_OPTS="-server \
-Xms4g \
-Xmx4g \
-Xss512k \
-XX:MetaspaceSize=256m \
-XX:NewRatio=2 \
-XX:+PrintTenuringDistribution \
-XX:+PrintHeapAtGC \
-XX:+UseConcMarkSweepGC \
-XX:+UseParNewGC  \
-XX:+UseCMSCompactAtFullCollection  \
-XX:CMSFullGCsBeforeCompaction=5 \
-XX:CMSInitiatingOccupancyFraction=70 \
-XX:+CMSClassUnloadingEnabled \
-XX:+PrintGCDetails \
-XX:+PrintGCDateStamps \
-Xloggc:/java/gc-%t-%p.log \
-XX:+HeapDumpBeforeFullGC \
-XX:+HeapDumpOnOutOfMemoryError \
-XX:HeapDumpPath=/java \
-XX:+PrintClassHistogramBeforeFullGC \
-XX:+PrintClassHistogramAfterFullGC \
-XX:ErrorFile=/java/hs_err_pid%p.log" \
JAVA_TOOL_OPTIONS="-javaagent:/java/agent/skywalking-agent.jar \
-Dskywalking.collector.backend_service=${SKYWALKING_SERVER_ADDR} \
-Dskywalking.agent.service_name=${APP_NAME} \
-Dskywalking.trace.ignore_path=/actuator/**"

ENTRYPOINT exec java $JVM_OPTS $JAVA_TOOL_OPTIONS \
-Dspring.cloud.nacos.config.server-addr=$CONFIG_SERVER_ADDR \
-Dspring.profiles.active=$APP_ACTIVE_PROFILE -jar /java/app.jar

# 登录私服仓库
# TAG=$(date '+%Y%m%d%H%M%S');
# docker login -u admin -p Harbor12345 39.108.3.126:3443
# 构建镜像
# docker build -t ahao/devops-project:$TAG . \
#   --build-arg DEFAULT_APP_ACTIVE_PROFILE=test \
#   --build-arg DEFAULT_SKYWALKING_SERVER_ADDR=39.108.3.126:8080 \
#   --build-arg DEFAULT_CONFIG_SERVER_ADDR=39.108.3.126:8848
# 上传镜像到harbor仓库
# docker tag ahao/devops-project:$TAG 39.108.3.126:3443/ahao/devops-project:$TAG
# docker push 39.108.3.126:3443/ahao/devops-project:$TAG
# 删除本地的临时镜像
# docker rmi ahao/devops-project:$TAG &> /dev/null
# docker rmi 39.108.3.126:3443/ahao/devops-project:$TAG &> /dev/null