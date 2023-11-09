#!/bin/bash

# Atualize os pacotes existentes
sudo apt update

# Instale o Java Development Kit (JDK)
sudo apt install default-jdk

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
