<div align="center">
  
![image](https://www.copimaq.com.br/wp-content/uploads/2020/10/Logo-topo-Menu.png)

</div>

# Servidor Web para desenvolvimento utilizando Docker!
Esta documentação foi desenvolvida com o objetivo de simplificar e facilitar a criação de um ambiente para desenvolvimento Web utilizando o Docker. 

Utilizamos a imagem oficial do [Ubuntu 22.04 LTS](https://hub.docker.com/layers/library/ubuntu/22.04/images/sha256-c985bc3f77946b8e92c9a3648c6f31751a7dd972e06604785e47303f4ad47c4c?context=explore) juntamente com o servidor web Apache e um servidor SSH para acessar remotamente o ambiente gerenciar os conteudos do servidor.

Já existe uma imagem pré-criada no Docker Hub, porém disponibilizei todos os arquivos para caso você saiba e prefira personalizar a imagem.
Caso não saiba realizar a personalização da imagem utilize a [Documentação Oficial](https://docs.docker.com/build/).

## Rodando o container
Para rodar o container de forma simples, utilize o seguinte comando
~~~bash
docker run -d -p 80:80 -p 22:22 suporteticopimaq/webserver:1.2
~~~
Como uma segunda opção, foi disponibilizado um arquivo `docker-compose.yml` que além de automatizar a criação do container, vai também disponibilizar a criação automatica de volumes para os diretorios de configuração do Apache `/etc/apache2/` e para o diretorio web `/var/www/html/`.

_O arquivo `docker-compose.yml` é personalizavel para se adequar a todas as necessidades._

`docker-compose.yml`
~~~yml
version: '3.0'

volumes:
  config:
  data:

services:
  webserver:
    image: suporteticopimaq/webserver:1.2
    ports: 
      - 80:80
      - 22:22
    restart: always   
    volumes:
      - config:/etc/apache2/
      - data:/var/www/html/
~~~

A vantagem de utilizar o docker compose é que além de facilitar o gerenciamento, facilita também a realização de backups dos arquivos que são persistentes utilizando os [volumes do Docker](https://docs.docker.com/storage/volumes/).

