#!/bin/sh

# Altera a senha do usuario root
echo "root:$ROOT_PASSWORD" | chpasswd

# Altera o diretorio primario que aparecerá quando realizar o login
echo "cd /var/www/html/" >> /root/.bashrc

# Inicia os serviços Web e SSH
service ssh start
service apache2 start

# Deixa o container rodando infinitamente
sleep infinity
