# Roteiro de instalação do Apache Nifi Registry em um ambiente Unix.
* **Criado por:** Anselmo Borges
* **Ultima atualização:** 22.05.2020

## Instalando o JDK8
Caso você não tenha o Java instalado (no caso de ser um servidor apartado) use os passos abaixo, caso vá usar no mesmo server onde você criou o Nifi, 

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
## Baixando o Nifi Registry:
Vamos fazer o download no link abaixo, o arquivo tem 74MB é bem rápido pra baixar:
```
wget https://downloads.apache.org/nifi/nifi-registry/nifi-registry-0.6.0/nifi-registry-0.6.0-bin.tar.gz
```
## Descompactando o arquivo:
Agora com o Download feito vamos descompactar o Nifi.
```
tar zfxv nifi-registry-0.6.0-bin.tar.gz
```

## Iniciando o Nifi:
Agora entramos dentro do diretório do Nifi e rodamos os script de inicialização do serviço:
```
cd nifi-registry-0.6.0
bin/nifi-registry.sh start
```
## Verificando o Start do serviço:
No mesmo diretório para verificar os logs posso rodar o comando abaixo:
```
tail -300f logs/nifi-registry-app.log
```
Caso as mensagens apareçam assim:
```
2020-05-22 01:58:42,266 INFO [main] o.eclipse.jetty.server.AbstractConnector Started ServerConnector@78e67e0a{HTTP/1.1,[http/1.1]}{0.0.0.0:18080}
2020-05-22 01:58:42,266 INFO [main] org.eclipse.jetty.server.Server Started @11101ms
2020-05-22 01:58:42,267 INFO [main] o.apache.nifi.registry.jetty.JettyServer NiFi Registry has started. The UI is available at the following URLs:
2020-05-22 01:58:42,267 INFO [main] o.apache.nifi.registry.jetty.JettyServer http://192.168.1.41:18080/nifi-registry
2020-05-22 01:58:42,267 INFO [main] o.apache.nifi.registry.jetty.JettyServer http://127.0.0.1:18080/nifi-registry
2020-05-22 01:58:42,270 INFO [main] o.apache.nifi.registry.BootstrapListener Successfully initiated communication with Bootstrap
2020-05-22 01:58:42,271 INFO [main] org.apache.nifi.registry.NiFiRegistry Registry initialization took 10634856390 nanoseconds (10 seconds).
```
É sinal que o Nifi iniciou com sucesso e você pode validar colando o link abaixo no navegador:
```
http://127.0.0.1:18080/nifi-registry
```
Se tudo deu certo, você vai ver a tela abaixo:
[![](https://github.com/AnselmoBorges/udemy02/blob/master/passoapasso/72E646DB-975A-4B8B-BCC4-7C3121D74FF4_4_5005_c.jpeg)

