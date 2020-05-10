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

## Validando a instalação do Java:
A validação do Java pode ser realizada em qualquer um desses ambientes com o comando abaixo:
```
java -version

java version "1.8.0_231"
Java(TM) SE Runtime Environment (build 1.8.0_231-b11)
Java HotSpot(TM) 64-Bit Server VM (build 25.231-b11, mixed mode)
```
## Baixando o Nifi:
Vamos fazer o download no link abaixo, o arquivo tem 1,3GB o que pode demorar de 10 a 15 min dependendo da internet:
```
wget https://downloads.apache.org/nifi/1.11.4/nifi-1.11.4-bin.tar.gz
```
## Descompactando o arquivo:
Agora com o Download feito vamos descompactar o Nifi.
```
tar zfxv nifi-1.11.4-bin.tar.gz
```

## Iniciando o Nifi:
Agora entramos dentro do diretório do Nifi e rodamos os script de inicialização do serviço:
```
cd nifi-1.11.4
bin/nifi.sh start
```
## Verificando o Start do serviço:
No mesmo diretório para verificar os logs posso rodar o comando abaixo:
```
tail -300f logs/nifi-app.log
```
Caso as mensagens apareçam assim:
```
2020-05-09 23:49:25,486 INFO [main] org.apache.nifi.web.server.JettyServer NiFi has started. The UI is available at the following URLs:
2020-05-09 23:49:25,486 INFO [main] org.apache.nifi.web.server.JettyServer http://192.168.1.41:8080/nifi
2020-05-09 23:49:25,486 INFO [main] org.apache.nifi.web.server.JettyServer http://127.0.0.1:8080/nifi
```
É sinal que o Nifi iniciou com sucesso e você pode validar colando o link abaixo no navegador:
```
http://localhost:8080/
```
Se tudo deu certo, você vai ver a tela abaixo:
[![](https://github.com/AnselmoBorges/udemy02/blob/master/passoapasso/nifi.png)

