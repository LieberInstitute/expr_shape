#!/bin/bash 
#$ -cwd
# Specify log file names
#$ -o exonInfo_regs.txt
#$ -e exonInfo_regs.txt
#$ -m e

echo "**** JHPCE info ****"
echo "User: ${USER}"
echo "Job id: ${JOB_ID}"
echo "Job name: ${JOB_NAME}"
echo "Hostname: ${HOSTNAME}"
echo "Task id: ${TASK_ID}"

date
Rscript exonInfo_regs.R
date
