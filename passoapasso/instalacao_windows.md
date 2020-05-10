# Instalação Apache Nifi no Windows
* **Criado por:** Anselmo Borges
* **Última atualização:** 11.05.2020

## Instalando pré requisitos.
Nessa parte vamos realizar o Download do Oracle JDK 8 e configurar as variáveis de ambiente.

### Fazendo o Download do Oracle JDK:
Para o download do JDK é preciso realizar o cadastro no site da Oracle. É bem rapido, caso contrário você não consegue fazer o download.
Para baixar acessamos o link abaixo:
```
https://www.oracle.com/java/technologies/javase-jdk8-downloads.html
```

O Download deve ser feito nesses links de acordo com o seu Windows (x32 ou x64)
![](https://github.com/AnselmoBorges/udemy02/blob/master/passoapasso/download_java.png)

### Instalando o Oracle JDK:
Uma instalação no Windows não tem muito segredo, basta dar next, next e finish como vocês já sabem, rs.

### Configurando variáveis de ambiente.
O Nifi para iniciar precisa que se configure uma variavel de ambiente JAVA_HOME, temos 2 formas de fazer isso, podemos editar o arquivo run-nifi.bat adicionando "set JAVA_HOME=c:\caminho\do\java" ou posso declarar as variáveis de ambiente do windows com o procedimento abaixo:

**Entre no explorer e clique com o botão direito do mouse em "este computador" e clica em propriedades.**<br>
![](https://github.com/AnselmoBorges/udemy02/blob/master/passoapasso/Imagem%2010-05-2020%20a%CC%80s%2018.15.jpeg)

**Clique em configurações avançadas do sistema**<br>
![](https://github.com/AnselmoBorges/udemy02/blob/master/passoapasso/Imagem%2010-05-2020%20a%CC%80s%2018.17.jpeg)

**Clique em variáveis de ambiente**<br>
![](https://github.com/AnselmoBorges/udemy02/blob/master/passoapasso/Imagem%2010-05-2020%20a%CC%80s%2018.20.jpeg)

**Clique em novo e adicione o nome da variável (JAVA_HOME) e o caminho**<br>
![](https://github.com/AnselmoBorges/udemy02/blob/master/passoapasso/Imagem%2010-05-2020%20a%CC%80s%2018.22.jpeg)
