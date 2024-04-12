Forked Repo : https://github.com/N4si/DevSecOps-Project
# DevSecOps Project: Netflix Clone Deployment Pipeline

## Overview

This project provides a comprehensive DevSecOps pipeline for deploying a Netflix clone application on the cloud using Jenkins for automation. The pipeline encompasses various phases, each addressing different aspects of the development, security, deployment, monitoring, and notification processes.

## Phases

### Phase 1: Initial Setup and Deployment
- Launches an EC2 instance on AWS with Ubuntu 22.04.
- Clones the application's code from a Git repository.
- Installs Docker and runs the application as a container.
- Obtains an API key from TMDB (The Movie Database) for the application's functionality.

### Phase 2: Security
- Installs SonarQube and Trivy for scanning code for vulnerabilities.
- Integrates SonarQube with the CI/CD pipeline to analyze code quality and security issues.

### Phase 3: CI/CD Setup
- Installs Jenkins for automation and sets up necessary plugins.
- Configures Java and Node.js in Global Tool Configuration.
- Creates a CI/CD pipeline in Jenkins to automate application deployment.
- Installs Dependency-Check and Docker Tools in Jenkins for security scanning.
- Adds DockerHub credentials for secure Docker image handling.

### Phase 4: Monitoring
- Installs Prometheus and Grafana for monitoring the application.
- Sets up Prometheus to scrape metrics from Node Exporter and Jenkins.
- Integrates Jenkins with Prometheus for CI/CD pipeline monitoring.

### Phase 5: Notification
- Implements email notifications in Jenkins or other notification mechanisms for informing stakeholders about build statuses or issues.

## Usage
- Follow the instructions provided in each phase to set up and configure the pipeline.
- Ensure that necessary dependencies and prerequisites are met before proceeding with each phase.
- Refer to individual phase sections for detailed steps and configurations.
