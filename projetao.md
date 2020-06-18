# Projetão
Projeto final do curso de Apache Nifi - Zero to Hero. Nesse projeto vamos coletar dados do Covid-19 de algumas fontes, tratar pelo Apache Nifi e fazer modificação e ingestão desses dados em um index Elasticsearch e os seus dados disponibilizar via Dashboard do Kibana.

Todo esse ambiente vai ser criado em Docker via Docker compose.<br>
**É muito importante que esse passo seja executado a risca para que o final, portanto:**

* O ambiente deverá ser criado em Docker, não em OpenShift, não em Kubernetes, não em baremetal, não em Windows, pode até ser um Docker no Windows mas tem que ser em Docker, qualquer coisa fora isso não posso dar suporte.
* Siga exatamente os passos desse material, deu erro? Volte reveja, ainda assim deu erro, me chame e vejo se coloquei algo errado, estou repassando passo a passo desse material validando cada comando.
* "Ah mas não manjo de Docker!", "Não manjo de Linux!", não vai ser desculpa para você não fazer esse passo a passo, vou deixar todos os comandos bem detalhados e vou me por a disposição pra que caso alguma particularidade aconteça, criar materiais adicionais.
* Como entrar em contato comigo? Pelo chat do Udemy, demoro algumas horas pra responder mais respondo, ou pelo Linkedin, me adiciona lá, tem o link na minha bio aqui do Udemy.

## Pré-requisitos
Quais os pré requisitos para a criação desse ambiente:
1. Ter o Docker e o Docker compose instalado, caso tenha um Linux, mostro como fazer nos materiais anteriores, caso tenha um Mac, basta fazer o Download nesse link https://hub.docker.com/editions/community/docker-ce-desktop-mac/
2. Para usar o Docker em Windows, você precisa ter um Windows Pro caso tenha um Home edition não funciona, caso o seu seja PRO o link para baixar é esse (Download from Docker Hub) o seu computador tem que ter mais do que 4 GB de RAM (Recomendadissimo).
3. Caso seu windows seja Home, não se desespere, você pode usar uma maquina virtual com Linux e instalar o docker com os passos que colocarei aqui. Ou criar uma maquina com Linux na Cloud de sua preferencia (AWS, Azure, GCP) com Linux e lá instalar o Docker. Isso já requer algumas customizações como criação de regras de firewall e outras coisa que não farão parte desse material mas tenho um link de um video onde subi algumas maquinas no GCP com mongoDB que podem ajudar (https://www.youtube.com/watch?v=auc6GSTILW4&t=449s)
4. Ter o Docker, já falei?

## Auxiliando a instalação do Docker:
Pra você que nunca usou o Docker, por que estou insistindo no uso dele? Ele vai trazer uma agilidade absurda na entrega do nosso projeto subindo os nossos 5 ambientes em no máximo 10 min com um unico comando. 

Caso usassemos outras alternativas como instalação do fonte, configuração de parâmetros esse processo poderia demorar horas. Nos comando abaixo caso você esteja usando Linux como nos exemplos de instalação de Nifi no Docker ele ensina como instalar o compose, caso já tenha feito esqueça segue o jogo.

Nas versões do Docker no Windows e no MacOS já vem o compose instalado, por tanto desconsidere o passo abaixo:

## Pré requisitos no S.O:
* Docker instalado
* Docker compose instalado
* Git instalado

## Instalando Pré-reqs (caso esteja usando Linux como disse acima)
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
É um arquivo yml que vem com as configurações necessárias para subirmos esses dados em Docker para iniciarmos os trabalhos. Maiores detalhes sobre o conteudo dele, basta ver o vídeo.

## Baixando o repositorio do curso:
Agora vamos fazer o download dos arquivos do curso para podermos dar inicio a criação do ambiente, vamos baixar via Git, eu custumo baixar via linha de comando mas vc pode fazer o download como sentir no coração, desde que baixe:
```
git clone https://github.com/AnselmoBorges/udemy02.git
```

O clone desse repositorio vai baixar a pasta udemy02 onde dentro dela tem 3 pastas compose, vamos entrar na pasta compose3.
```
cd udemy02/compose3
```

Assim que entramos dentro desse diretório temos um arquivo docker-compose.yml o qual no vídeo explico melhor basicamente já faz as seguintes configurações pra você:
* Nifi (ultima versão) na porta 8080
* Elasticsearch (ultima versão no momento 7.7) na porta 9200
* Kibana (ultima versão no momento 7.7) na porta 5601
* Postgres 11 na porta 5432
* PGAdmin4 na porta 80

Explicando as outras ferramentas caso você não conheça:
* Elasticsearch - Banco de dados NoSQL relacionado a documentos, parecidos com JSON.
* Kibana - Ferramenta gráfica que gerencia o funcionamento do Elastic, serve como console do consultas no ElasticSearch e uma ferramenta poderossima de criação de dashboards e outras várias coisas.
* Postgres - Banco de dados relacional free bem consolidado no mercado a anos.
* PgAdmin4 - Ferramenta Web de consultas aos dados do Postgres.

## Rodando o docker-compose ecriando o ambiente:
Bom agora que já sabemos tudo que será instalado vamos rodar um comando muito dificil que vai fazer a instalação desses 5 ambientes em minutos. Rodamos estando no diretório compose3 como disse acima.
```
docker-compose up -d
```
Ele vai fazer o download das imagens dos containers e já iniciar os 5 serviços pra você e no final se tudo deu certo ele tem que mostrar a seguinte mensagem pra vc!
```
Creating postgres      ... done
Creating elasticsearch ... done
Creating nifi          ... done
Creating kibana        ... done
Creating pgadmin4      ... done
```

Se essas mensagens foram exibidas amigos(as) vocês estão prontos para começar, existe outras configurações bem específicas que temos que fazer ainda mas já temos um ambiente (60% do projeto foi concluído acredite).

## Configurando Bibliotecas de acesso ao Postgres e criação das tabelas:
Nesse passo vamos realizar a configuração da biblioteca JDBC Postgres que vai permitir com que o Nifi faça acesso aos dados do Postgres via controller service. Também vamos criar a seguinte estrutura no Potgres:
* **Criar o Schema covid:** O Schema no postgres é um conjunto lógico que contem os dados como tabelas, views, procedures e etc.
* **Criar as 2 tabelas usadas no postgres** Nesse passo vamos criar a tabela covid_dados e a covid_ibge, cujo a criação dessa estrutura está no arquivo.sql que está no repositorio Git que baixamos a pouco no diretório udemy02/script/estrutura_postgres.sql.

### Jogando o jdbc dentro do container do Nifi:
No repositorio Git que baixamos, existe uma pasta chamada libs, vamos mover o conteudo desse diretorio para dentro do container nifi com o comando abaixo, **partindo do principío que estamos na pasta udemy02**:
```
cd libs
docker cp postgresql-42.2.11.jar nifi:/nifi/libs/
```
### Jogando o certificado dentro do container do Nifi:
No repositorio Git que baixamos, existe uma pasta chamada certificados, esse cara é um truststore do java que precisamos pra fazer download em APIs que usam HTTPS, você pode criar um seu mas já deixei ele configurado, a senha de dele é "senha123", agora vamos movimentá-lo para o container assim como o anterior:
```
cd ..
cd certificados
docker cp cacerts nifi:/nifi/libs/
```
**Caso esteja usando o Linux coloque um sudo na frente do comando docker**

### Criando a estrutura Postgres via PGAdmin4:
Vamos entrar via navegador no endereço abaixo:
```
http://localhost
```
Feito isso a pagina do PGadmin4 vai ser aberta solicitando o login (caso não tenha alterado no compose, use os dados abaixo):
* **Usuário:** seuemail@email.com.br
* **Senha:** suasenha

Feito isso você será levado a pagina inicial do PGAmin4 onde vamos cadastrar um novo servidor, entre com os dados abaixo (caso não tenha alterado no compose também):
* **Nome:** Projetao
* **Host:** postgres (pois é o nome que demos no Docker compose)
* **Usuário:** postgres
* **Senha:** suasenha 

As demais informações não são necessárias. Conecte-se ao banco Potgres e vamos abrir a execução de queries para importar o estrutura_postgres.sql citado acima, o mesmo se encontra no diretorio 

Na imagem abaixo, podemos ver como fazer isso mais se ficar dúvida veja o vídeo.

Executando o arquivo criamos as seguintes estruturas:
* Criação do schema covid
* Criação da tabela covid.covid_casos
* Criação da tabela covid.municipios

## Importando dados do arquivo CSV para a tabela covid.covid_ibge:
Agora nesse projeto temos uma única tabela estática (que não será modificada) que é a do código do IBGE com a longitude e latitude de cada município, na outra tabela vamos trazer os dados do API, o Nifi vai fazer o processo de Merge dessas 2 tabelas e o resultado vai ser um JSON com os dados da API + a Geolocalização dos municípios, possibilitando assim mostrar no Kibana qual o numero de casos por municipio em um mapa como mostrado no video do capítulo anterior:

* Verificar como é feito no vídeo:

## Criando o indice no Elasticsearch:
O indice no Elaticsearch funciona como um database em um banco de dados convencional. Por padrão o Elaticsearch cria o indice se você não possui um, mas do jeito dele, as vezes ele não faz o mapping com os datatypes corretos. Sendo assim vamos deixar a criação no esquema.

### Entrando no Kibana e deixando o Script no dev_tools:
O Dev_tools é a ferramenta onde rodamos as queries do Elasticsearch, vamos pegar o script create_mapping.es no diretorio scripts e já deixar na tela pronto pra rodar. Para entrar no Kibana basta entrar no link abaixo e no dev_tools o icone da chavinha na lateral esquerda.
```
http://localhost:5601
```
### Importando o Template no Nifi:
Como sou um cara muito legal já deixei um template configurado, no vídeo eu explico o que cada uma das partes realiza nesse processo. O template está na pasta templates e vamos fazer a importação dele da seguinte forma, primeiro logamos no Nifi.
```
http://localhost:8080
```
Agora entramos em upload template:
[!](https://github.com/AnselmoBorges/udemy02/blob/master/passoapasso/265D64CE-A3B5-4E57-8762-F432BCF6AC10_4_5005_c.jpeg)

Depois clicamos em select e depois em upload:
[!](https://github.com/AnselmoBorges/udemy02/blob/master/passoapasso/A784D852-5D09-4256-B984-98F8EFFF402B_4_5005_c.jpeg)
