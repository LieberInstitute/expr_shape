#!/bin/bash 
#$ -cwd
# Specify log file names
#$ -o regInfo_percent.txt
#$ -e regInfo_percent.txt
#$ -m e

echo "**** JHPCE info ****"
echo "User: ${USER}"
echo "Job id: ${JOB_ID}"
echo "Job name: ${JOB_NAME}"
echo "Hostname: ${HOSTNAME}"
echo "Task id: ${TASK_ID}"

date
Rscript regInfo_percent.R
date
