#!/usr/bin/env bash

ENV=production
export JENKINS_ENV_FILE=jenkins.${ENV}.yaml

if [ ! -f "env/$JENKINS_ENV_FILE" ]; then
  echo "env/$JENKINS_ENV_FILE does not exist, please create the corresponding JCasC configuration file first!"
  exit 1
fi

echo "Using JCasC config: env/$JENKINS_ENV_FILE"

sudo mkdir -p /opt/jenkins_jobs
sudo chown -R 1000:1000 /opt/jenkins_jobs
sudo chown 1000:1000 env/jenkins.*.yaml

echo "Restarting Jenkins production environment..."

# Stop service
echo "Stopping Jenkins..."
docker compose down

# Start service
echo "Starting Jenkins..."
docker compose up -d

echo "Jenkins production environment restarted successfully!"
echo "Access Jenkins at: http://localhost:8888" 