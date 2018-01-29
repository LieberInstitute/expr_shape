#!/bin/bash 
#$ -cwd
# Specify log file names
#$ -o logs/subtissue_exon.$TASK_ID.txt
#$ -e logs/subtissue_exon.$TASK_ID.txt
#$ -t 1-14
#$ -m e
#$ -l bluejay,mem_free=100G,h_vmem=100G,h_fsize=100G

echo "**** JHPCE info ****"
echo "User: ${USER}"
echo "Job id: ${JOB_ID}"
echo "Job name: ${JOB_NAME}"
echo "Hostname: ${HOSTNAME}"
echo "Task id: ${TASK_ID}"

date
Rscript subtissue_exon.R
date
