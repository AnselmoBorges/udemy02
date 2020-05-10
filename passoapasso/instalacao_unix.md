# Roteiro de instalação do Apache Nifi em um ambiente Unix.
* **Criado por:** Anselmo Borges
* **Ultima atualização:** 10.05.2020

## Instalando o JDK8
Como estou realizando a instalação em um ambiente MacOS eu vou usar o Brew para instalar o Java, mas segue os comandos nos demais ambientes:

**Ambientes baseados em Debian**<br>
```
sudo apt install default-jdk
```
**Ambientes baseados em Redhat**<br>
```
sudo yum install java-1.8.0-openjdk 
```
**Ambientes MacOS**
```
brew install java
```

## Validando a instalação do Java
A validação do Java pode ser realizada em qualquer um desses ambientes com o comando abaixo:
```
 Anselmo@fsociety  ~  java -version
java version "1.8.0_231"
Java(TM) SE Runtime Environment (build 1.8.0_231-b11)
Java HotSpot(TM) 64-Bit Server VM (build 25.231-b11, mixed mode)
```

