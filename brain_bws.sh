#!/bin/bash 
#$ -cwd
# Specify log file names
#$ -o brain_bws.txt
#$ -e brain_bws.txt
#$ -m e
#$ -l mem_free=200G,h_vmem=200G,h_fsize=200G

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
Rscript brain_bws.R
date

