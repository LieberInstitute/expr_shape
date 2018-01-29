#!/bin/bash 
#$ -cwd
# Specify log file names
#$ -o logs/subtissue_bws.$TASK_ID.txt
#$ -e logs/subtissue_bws.$TASK_ID.txt
#$ -t 12
#$ -m e
#$ -l bluejay,mem_free=100G,h_vmem=100G,h_fsize=100G

echo "**** JHPCE info ****"
echo "User: ${USER}"
echo "Job id: ${JOB_ID}"
echo "Job name: ${JOB_NAME}"
echo "Hostname: ${HOSTNAME}"
echo "Task id: ${TASK_ID}"

date
module load wiggletools/default
module load ucsctools
module load conda_R/3.4.x
Rscript subtissue_bws.R
date

