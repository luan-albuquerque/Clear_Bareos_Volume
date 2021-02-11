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



