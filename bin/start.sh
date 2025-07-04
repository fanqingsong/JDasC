#!/usr/bin/env bash

ENV=${1:-dev}  # 默认dev，可传staging/production
export JENKINS_ENV_FILE=jenkins.${ENV}.yaml

if [ ! -f "env/$JENKINS_ENV_FILE" ]; then
  echo "env/$JENKINS_ENV_FILE 不存在，请先创建对应的 JCasC 配置文件！"
  exit 1
fi

echo "Using JCasC config: env/$JENKINS_ENV_FILE"

# 创建 Jenkins jobs 目录（如果不存在）
echo "Creating Jenkins jobs directory if it doesn't exist..."
sudo mkdir -p /opt/jenkins_jobs
sudo chown -R 1000:1000 /opt/jenkins_jobs
sudo chown 1000:1000 env/jenkins.*.yaml
echo "Jenkins jobs directory ready: /opt/jenkins_jobs"

# 停止并删除现有容器
echo "Stopping and removing existing Jenkins container..."
docker compose down

# 构建镜像并启动服务
echo "Building and starting Jenkins with docker compose..."
docker compose up --build -d --force-recreate

echo "Jenkins is now running for $ENV! Access at: http://localhost:8888"
