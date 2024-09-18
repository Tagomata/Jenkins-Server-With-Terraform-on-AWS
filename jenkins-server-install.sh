#!/bin/bash
# Actualizar los paquetes del sistema
sudo apt update -y
sudo apt upgrade -y

# Instalar Vim, OpenSSH Server y Net-tools
sudo apt install -y vim openssh-server net-tools

# Instalar Docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install -y docker-ce

# Habilitar Docker para que inicie al arrancar el sistema
sudo systemctl start docker
sudo systemctl enable docker

# Añadir el usuario ubuntu al grupo docker para evitar usar sudo con Docker
sudo usermod -aG docker ubuntu

# Instalar Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verificar la instalación de Docker Compose
docker-compose --version

# Crear el directorio de Jenkins
mkdir -p /home/ubuntu/jenkins

# Crear el archivo docker-compose.yml
cat <<EOL > /home/ubuntu/jenkins/docker-compose.yml
version: '3'
services:
  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins
    user: root
    privileged: false
    ports:
      - 8080:8080
      - 50000:50000
    volumes:
      - /home/ubuntu/jenkins_home:/var/jenkins_home
    networks:
      - net
    restart: unless-stopped
    environment:
      - JAVA_OPTS=-Xmx512m
    deploy:
      resources:
        limits:
          cpus: "0.5"
          memory: 800M

networks:
  net:
EOL

# Dar permisos adecuados al directorio
sudo chown -R ubuntu:ubuntu /home/ubuntu/jenkins

# Ir al directorio donde está el docker-compose.yml y ejecutar Jenkins
cd /home/ubuntu/jenkins
sudo docker-compose up -d

# Abrir el puerto 8080 y 50000 en el firewall para Jenkins y SSH
sudo ufw allow 8080
sudo ufw allow 50000
sudo ufw allow OpenSSH
sudo ufw enable
