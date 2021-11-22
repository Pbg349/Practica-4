#/bin/bash
set -x

#----------------------------------------------------------------------

#Variables Configuración:

MYSQL_ROOT_PASSWORD=root

#----------------------------------------------------------------------

# Instalamos la pila LAMP

# Actualizamos sistema:

apt update
apt upgrade -y

# Instalamos Apache2:

apt install apache2 -y
 
# Instalamos php-mysql:

apt install php libapache2-mod-php php-mysql -y

# Reiniciamos el servidor apache2:

systemctl restart apache2


#------------------------------------------------------------------------------------------


#Configuramos MYSQL:

# Cambiamos la contraseña del usuario root:

mysql <<< "ALTER USER root@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';"

# Configuramos MySQL para aceptar conexiones desde cualquier interfaz de red:

sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniciamos el servicio de MySQL:

systemctl restart mysql
