env | grep T411_ | sed "s/T411_/export T411_/g" >> /etc/environment
env | grep MYSQL_PORT_3306_TCP_ADDR | sed "s/MYSQL_PORT_3306_TCP_ADDR/export MYSQL_PORT_3306_TCP_ADDR/g" >> /etc/environment
env | grep MYSQL_ENV_MYSQL_ROOT_PASSWORD | sed "s/MYSQL_ENV_MYSQL_ROOT_PASSWORD/export MYSQL_ENV_MYSQL_ROOT_PASSWORD/g" >> /etc/environment
env | grep MYSQL_ENV_MYSQL_DATABASE | sed "s/MYSQL_ENV_MYSQL_DATABASE/export MYSQL_ENV_MYSQL_DATABASE/g" >> /etc/environment