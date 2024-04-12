#!/bin/bash

sudo apt-get update -y
sudo apt-get install docker.io -y
sudo usermod -aG docker $USER
newgrp docker
sudo chmod 777 /var/run/docker.sock



sudo apt update -y
sudo apt install fontconfig openjdk-17-jre -y
java -version

sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update -y
sudo apt-get install trivy -y

#jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins



echo 'export API_KEY="b4a35d4f223d038cb73cf86bd13f5050"' >> ~/.bashrc
echo 'export API_SECRET="eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNGEzNWQ0ZjIyM2QwMzhjYjczY2Y4NmJkMTNmNTA1MCIsInN1YiI6IjY2MTNmMDcxOGVlMGE5MDEzMmEzODhhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1VtueCuIJ4zx3doYDYBz2nU4QX4VEbrqX1rO4AtpKfk"' >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/samiselim/DevSecOps-Netflix-Deployed-Application.git
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
docker build --build-arg TMDB_V3_API_KEY=$API_KEY -t netflix ./DevSecOps-Project/
