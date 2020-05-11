# Instalação Apache Nifi no Docker
* **Criado por:** Anselmo Borges
* **Ultima atualização:** 11.05.2020

Nesse material, vamos realizar a instalação do Apache Nifi usando o Docker e vocês vão perceber, pra quem nunca usou é absurdamente mais simples.
Para realizarmos essa instalação pode ser com o Docker tanto no Linux, Windows e MacOS. O Docker pra rodar no Windows precisa que seja Windows 10 Pro, outros tipos de edições não funciona.

Vamos precisar ter também o docker compose, no Windows e Mac já vem padrão, no Windowse no Mac já vem com compose, no Linux alem de instalar o Docker tem que instalar o compose.
Então vamos lá, vamos iniciar o procedimento abaixo, mostra a instalação do Docker em um ambiente Linux, a instalação Windows/Mac é meio intuitiva, baixando o executavel e Next, next, finish.:

## Pré requisitos no S.O:
* Docker instalado
* Docker compose instalado
* Git instalado

## Instalando Pré-reqs
Para instalar todos os pré reqs citados acima rode os comandos abaixo:

```
sudo yum update -y
sudo yum install docker git -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

Com tudo instalado validamos o docker compose:

```
docker-compose -version
```
## Docker compose
É um arquivo yml que vem com as configurações necessárias para subirmos esses dados em Docker para iniciarmos os trabalhos. Maiores detalhes sobre o conteudo dele, basta ver o vídeo abaixo.

## Baixando esse repositório via Git:
Para baixar o repositorio com o compose digite o comando abaixo:
```
git clone https://github.com/AnselmoBorges/udemy02.git
```
Entre dentro do diretório baixado:
```
cd udemy02/compose
```

## Realize o start do deamon do Docker:
Por padrão o Docker não vem iniciado, sendo assim rodamos os comandos abaixo para iniciar o Docker:
```
sudo service docker start
```

## Como fazer a execução.
Com o docker e o docker-compose instalados (no meu caso num Linux) basta baixar esse conteudo via ```git clone``` e entrando na pasta baixada rodar o comando abaixo:

```
sudo docker-compose up -d
```

Não precisa passar o nome do arquivo pois ele considera que já está no diretório corrente e certifique-se disso, rs. O conteúdo de cada uma das imagens será baixado o que pode demorar um pouco, mas estando tudo no ar basta acessar no navegador com ```http://localhost:8080```:

Dando tudo certo só acessar via navegador.
