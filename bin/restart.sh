#!/usr/bin/env bash

ENV=${1:-dev}  # 默认dev，可传staging/production
export JENKINS_ENV_FILE=jenkins.${ENV}.yaml

if [ ! -f "env/$JENKINS_ENV_FILE" ]; then
  echo "env/$JENKINS_ENV_FILE 不存在，请先创建对应的 JCasC 配置文件！"
  exit 1
fi

echo "Using JCasC config: env/$JENKINS_ENV_FILE"

sudo mkdir -p /opt/jenkins_jobs
sudo chown -R 1000:1000 /opt/jenkins_jobs
sudo chown 1000:1000 env/jenkins.*.yaml

echo "Restarting Jenkins service..."

# 停止服务
echo "Stopping Jenkins..."
docker compose down

# 启动服务
echo "Starting Jenkins..."
docker compose up -d

echo "Jenkins service restarted successfully!"
echo "Access Jenkins at: http://localhost:8888" 