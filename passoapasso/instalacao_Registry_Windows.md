# Instalação Nifi Registry no Windows
* **Criado por:** Anselmo Borges
* **Última atualização:** 11.05.2020

## Pré-requisitos
Vamos partir da premissa que realizamos a instalação do Java e do Apache Nifi, portanto nesse roteiro vamos sair desse ponto. Caso não tenha feito segue link com o tutorial abaixo:

[Instalando Nifi no Windows](https://github.com/AnselmoBorges/udemy02/blob/master/passoapasso/instalacao_windows.md)

## Fazendo o Download do Nifi Registry para Windows:
Para esse instalação vamos usar o arquivo .zip fazendo o download do link abaixo:

https://downloads.apache.org/nifi/nifi-registry/nifi-registry-0.6.0/nifi-registry-0.6.0-bin.zip

## Descompactando e iniciando o serviço.
Iremos descompactar o arquivo .zip baixado e na sua pasta terá a seguinte distribuição:

Abra o prompt do MS-DOS, entre nesse diretório descompactado, no diretório bin e execute o comando abaixo:
```
run-nifi-registry.bat
```

Após executar esse comando, caso a variável do JAVA_HOME tenha sido setada, o processo de start do Nifi será iniciado e pode ser verificado na pasta logs no arquivo nifi-app.log.

Quando aparecer que os serviços na porta 8080 estão disponiveis (o que leva uns 4 minutos), só acessar o navegador no endereço abaixo e validar se o serviço do Nifi foi iniciado.

http://localhost:18080

Se tudo correu bem, você verá a página inicial do Nifi.
