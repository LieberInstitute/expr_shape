#!/bin/bash 
#$ -cwd
# Specify log file names
#$ -o logs/subtissue_ers.$TASK_ID.txt
#$ -e logs/subtissue_ers.$TASK_ID.txt
#$ -t 1-14
#$ -m e
#$ -pe local 5
#$ -l bluejay,mem_free=16G,h_vmem=16G,h_fsize=100G

echo "**** JHPCE info ****"
echo "User: ${USER}"
echo "Job id: ${JOB_ID}"
echo "Job name: ${JOB_NAME}"
echo "Hostname: ${HOSTNAME}"
echo "Task id: ${TASK_ID}"

date
module load conda_R/3.4.x
Rscript subtissue_ers.R
date


