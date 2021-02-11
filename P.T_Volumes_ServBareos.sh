#!/bin/bash
#################################################
#
#     Console Script Purge and Truncate for Volumes
#     Escrito por: Luan Albuquerque dos Santos
#     Last Update: 27/10/2020
#
#################################################

######### DADOS DATABASE BAREOS #################
MYSQL_HOST='localhost'
MYSQL_PORT='3306'
MYSQL_USER='root'
MYSQL_PASSWORD='bareos'
DATABASE_NAME='bareos'
#################################################

####################PARAMETROS###################

DATA_CLS=2021-01-26
STORAGE=1;

#################################################

######## ARRAY OBTENDO OS VOLUMESNAMES #########
VALUES_SQL=$(mysql -u $MYSQL_USER \
                   -e "select CONVERT(VolumeName USING utf8) from Media where S$
                      $DATABASE_NAME )
array=()
while read line
do 
[[ "$line" != '' ]] && array+=("$line")
done <<< "$VALUES_SQL"
echo ${array[1]};
################################################

#### ARRAY OBTENDO CONTADOR DOS VOLUMENAMES ####
COUNT_SQL=$(mysql -u root -e "select COUNT(VolumeName) from Media where Storage$

arraysec=()
while read count_line
do
[[ "$count_line" != '' ]] && arraysec+=("$count_line")
done <<<"$COUNT_SQL"
echo ${arraysec[1]};
################################################

########## LAÇO DO PURGE E TRUNCATE ############
#Criação de Logs 
echo "LOG REGISTRADO $(date +%d_%m_%Y-%T)" >>  /var/lib/scriptBareos/$STORAGE/log_scriptCLS$(date +%d_%m_%Y).log
echo "VOLUMES (PURGED) | STORAGE ID = $STORAGE | LASTWRITTEN < $DATA_CLS | QUANTIDADE ${arraysec[1]}" >>  /var/lib/scriptBareos/$STORAGE/log_scriptCLS$(date +%d_%m_%Y).log


for i in $(seq 1 ${arraysec[1]});
do 

#Registrar os volumes que foram exluidos
echo "volume -> ${array[$i]}" >>  /var/lib/scriptBareos/$STORAGE/log_scriptCLS$(date +%d_%m_%Y).log

bconsole <<END_OF_DATA

purge volume=${array[$i]}
truncate volstatus=Purged volume=${array[$i]} yes 

quit
END_OF_DATA
done
#Registrar Fim
echo " FIM DE REGISTRO DE LOG -> $(date +%d_%m_%Y-%T)" >> /var/lib/scriptBareos/$STORAGE/log_scriptCLS$(date +%d_%m_%Y).log







