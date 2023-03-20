<div align="center">
  
![image](https://www.copimaq.com.br/wp-content/uploads/2020/10/Logo-topo-Menu.png)

</div>

# Servidor Web para desenvolvimento utilizando Docker!
Esta documentação foi desenvolvida com o objetivo de simplificar e facilitar a criação de um ambiente para desenvolvimento Web utilizando o Docker. 

Utilizamos a imagem oficial do [Ubuntu 22.04 LTS](https://hub.docker.com/layers/library/ubuntu/22.04/images/sha256-c985bc3f77946b8e92c9a3648c6f31751a7dd972e06604785e47303f4ad47c4c?context=explore) juntamente com o servidor web Apache e um servidor SSH para acessar remotamente o ambiente gerenciar os conteudos do servidor.

Foi instalado previamente o [Python](https://www.python.org/) e o [Java](https://www.java.com/), para facilitar no desenvolvimento de aplicações para o servidor Web.

Já existe uma imagem pré-criada no Docker Hub, porém disponibilizei todos os arquivos para caso você saiba e prefira personalizar a imagem.
Caso não saiba realizar a personalização da imagem utilize a [Documentação Oficial](https://docs.docker.com/build/).

## Rodando o container
Para rodar o container de forma simples, utilize o seguinte comando
~~~bash
docker run -d -p 80:80 -p 22:22 -e ROOT_PASSWORD=secret suporteticopimaq/webserver
~~~
No comando acima a tag `-e ROOT_PASSWORD` define a senha que será utilizada para acessar o container via ssh, o usuario padrão de acesso é o `root`.
 
Como uma segunda opção, foi disponibilizado dois arquivos `docker-compose.yml` que além de automatizar a criação do container, vai também disponibilizar a criação automatica de volumes para os diretorios de configuração do Apache `/etc/apache2/` e para o diretorio web `/var/www/html/`.

Arquivo `docker-compose.yml` somente com o servidor Web.
~~~yml
version: '3.0'

volumes:
  config:
  data:

services:
  webserver:
    image: suporteticopimaq/webserver
    ports:
      - 80:80
      - 22:22
    environment:
      - ROOT_PASSWORD=secret
    restart: always
    volumes:
      - config:/etc/apache2/
      - data:/var/www/html/
~~~

Arquivo `docker-compose.yml` somente com servidor Web e um servidor MySQL.
~~~yml
version: '3.0'

volumes:
  config:
  data:

services:
  webserver:
    image: suporteticopimaq/webserver
    ports:
      - 80:80
      - 22:22
    environment:
      - ROOT_PASSWORD=secret
    restart: always
    volumes:
      - config:/etc/apache2/
      - data:/var/www/html/

  mysql:
    image: mysql:8
    ports:
      - 3306:3306
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_DATABASE: database
      MYSQL_USER: user
      MYSQL_PASSWORD: password
    volumes:
      - mysql:/var/lib/mysql
~~~
_O arquivo `docker-compose.yml` é personalizavel para se adequar a todas as necessidades._

Na opção `ports` é possivel alterar a porta que o container respondera os serviços externamente, por exemplo, caso seja necessario que a porta HTTP seja a 8080, basta alterar o parametro `ports` de `- 80:80` para `- 8080:80`.

A variavel `ROOT_PASSWORD` é onde definimos a senha de root do container, então altere para uma senha forte. Lembre-se que o acesso ao container serve apenas para a personalização dos arquivos da pagina Web, não é recomendado realizar a instalação de nenhum pacote adicional, caso precise utilize o `Dockerfile` e crie uma imagem nova com todas as alterações necessarias.

A vantagem de utilizar o docker compose é que além de facilitar o gerenciamento, facilita também a realização de backups dos arquivos que são persistentes utilizando os [volumes do Docker](https://docs.docker.com/storage/volumes/).
