#!/bin/bash

# Atualize os pacotes existentes
sudo apt update

# Instale o Java Development Kit (JDK)
sudo apt install default-jdk openjdk-17-jdk openjdk-17-jre kotlin gradle apt-transport-https ca-certificates curl software-properties-common -y

# Baixe e instale o Kotlin Compiler (Kotlinc)
curl -s https://get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install kotlin

# Baixe e instale o Gradle
sudo apt install -y unzip
wget https://services.gradle.org/distributions/gradle-7.3.3-bin.zip -P /tmp
sudo unzip -d /opt/gradle /tmp/gradle-*.zip
sudo mv /opt/gradle/gradle-7.3.3 /opt/gradle/latest
echo 'export PATH=$PATH:/opt/gradle/latest/bin' >> ~/.bashrc
source ~/.bashrc

# Exiba as versões instaladas
java -version
kotlin -version
gradle -v

# Adicionar chave GPG do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Adicionar repositório do Docker
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualizar cache de pacotes novamente
sudo apt-get update

# Instalar Docker
sudo apt-get install -y docker-ce

# Instalar Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Reiniciar o serviço do Docker
sudo service docker restart