# Practica-4

En ésta práctica, procederemos como en la Práctica-3 de IAW "Arquitectura de una aplicación web LAMP en dos niveles" añadiendo una nueva máquina con servidor Apache, conectada a la arquitectura, creando una capa frontend con 2 servidores apache y una capa backend con un único servidor MYSQL, tal como en la práctica-3 nombrada anteriormente, la comprobación final del trabajo realizado será conectarnos desde ambas máquinas al servidor MYSQL:


# Primero configuraremos el Backend:


#/bin/bash
set -x

# ----------------------------------------------------------------------

## Variables Configuración:

MYSQL_ROOT_PASSWORD=root

# ----------------------------------------------------------------------

# Instalamos la pila LAMP

## Actualizamos sistema:

apt update
apt upgrade -y

## Instalamos Apache2:

apt install apache2 -y
 
## Instalamos php-mysql:

apt install php libapache2-mod-php php-mysql -y

## Reiniciamos el servidor apache2:

systemctl restart apache2


# ------------------------------------------------------------------------


# Configuramos MYSQL:

## Cambiamos la contraseña del usuario root:

mysql <<< "ALTER USER root@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';"

## Configuramos MySQL para aceptar conexiones desde cualquier interfaz de red (Anteriormente hubiese valido la IP de la única máquina que va a conectarse):

sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

## Reiniciamos el servicio de MySQL:

systemctl restart mysql

# ------------------------------------------------------------------------

# Ahora configuraremos ambas máquinas que formarán la capa Frontend:

## FRONTEND1:

#/bin/bash
set -x

# Variables de Configuración:

IP_MYSQL=172.31.10.177


# ------------------------------------------------------------------------


# Instalamos la pila LAMP:

## Actualizamos el sistema
apt update
apt upgrade -y

## Instalamos Apache:
apt install apache2 -y
 

## Instalamos php-mysql:
apt install php libapache2-mod-php php-mysql -y

## Reiniciamos el server apache:
systemctl restart apache2


# --------------------------------------------------------------------


# Herramientas adicionales:

## Adminer:

cd /var/www/html
mkdir adminer
cd adminer
wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php
mv adminer-4.8.1-mysql.php index.php

## Actualizamos propietario grupo de nuestro directorio /var/www/html
chown www-data:www-data /var/www/html -R 


# --------------------------------------------------------------------


# Aplicación Web:

cd /var/www/html

## Clonamos el repositorio
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git

## Movemos el codigo de la aplicación a /var/www/html

mv iaw-practica-lamp/src/* /var/www/html


## Eliminamos index.html

rm /var/www/html/index.html

## Eliminamos el directorio del repositorio

rm -rf /var/www/html/iaw-practica-lamp

## Configuramos la IP de MYSQL en el archivo config.php

sed -i "s/localhost/$IP_MYSQL/" /var/www/html/config.php


## Cambiamos propietario y grupo
chown www-data:www-data /var/www/html -R 


## Cambiamos el nombre de la página principal:

sed -i "s/Simple LAMP web app/LAMP Front1/" /var/www/html/index.php


# ----------------------------------------------------------------------------


## FRONTEND2:

#/bin/bash
set -x

# Variables de Configuración:

IP_MYSQL=172.31.10.177

# -------------------------------------------------------------------

# Instalamos pila LAMP:

## Actualizamos el sistema

apt update
apt upgrade -y

## Instalamos Apache:

apt install apache2 -y
 

## Instalamos php-mysql:

apt install php libapache2-mod-php php-mysql -y

## Reiniciamos el server apache:

systemctl restart apache2


# ---------------------------------------------------------------------


# Herramientas adicionales:

## Obetenemos Adminer:

cd /var/www/html

mkdir adminer

cd adminer

wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php

mv adminer-4.8.1-mysql.php index.php

## Actualizamos propietario grupo del directorio /var/www/html

chown www-data:www-data /var/www/html -R 


# --------------------------------------------------------------------


# Aplicación Web:

cd /var/www/html

## Clonamos repositorio:

git clone https://github.com/josejuansanchez/iaw-practica-lamp.git

## Movemos codigo de aplicación a /var/www/html:

mv iaw-practica-lamp/src/* /var/www/html


## Eliminamos index.html

rm /var/www/html/index.html

## Eliminamos el directorio del repositorio

rm -rf /var/www/html/iaw-practica-lamp

## Configuramos la IP de MYSQL en el archivo config.php del Front2

sed -i "s/localhost/$IP_MYSQL/" /var/www/html/config.php


## Cambiamos propietario y grupo

chown www-data:www-data /var/www/html -R 


## Cambiamos el nombre de la página principal de nuestro Front2:

sed -i "s/Simple LAMP web app/LAMP Front2/" /var/www/html/index.php

