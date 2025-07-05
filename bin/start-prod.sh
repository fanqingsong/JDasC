#!/usr/bin/env bash

ENV=production
export JENKINS_ENV_FILE=jenkins.${ENV}.yaml

if [ ! -f "env/$JENKINS_ENV_FILE" ]; then
  echo "env/$JENKINS_ENV_FILE does not exist, please create the corresponding JCasC configuration file first!"
  exit 1
fi

echo "Using JCasC config: env/$JENKINS_ENV_FILE"

# Create Jenkins jobs directory (if it doesn't exist)
echo "Creating Jenkins jobs directory if it doesn't exist..."
sudo mkdir -p /opt/jenkins_jobs
sudo chown -R 1000:1000 /opt/jenkins_jobs
sudo chown 1000:1000 env/jenkins.*.yaml
echo "Jenkins jobs directory ready: /opt/jenkins_jobs"

# Stop and remove existing containers
echo "Stopping and removing existing Jenkins container..."
docker compose down

# Build image and start service
echo "Building and starting Jenkins with docker compose..."
docker compose up --build -d --force-recreate

echo "Jenkins is now running for production environment! Access at: http://localhost:8888" 