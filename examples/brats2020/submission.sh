#!/bin/bash

##rm ./CNNJob.*
#/bin/echo Running on compute node: `hostname`.

#####Set Scheduler Configuration Directives#####
#Set the name of the job. This will be the first part of the error/output filename.
#$ -N CNNJob

#Set the current working directory as the location for the error and output files.
#(Will show up as .e and .o files)
#$ -cwd

#Send e-mail at beginning/end/suspension of job
#$ -m bes
##$ -m e

#E-mail address to send to
#$ -M seyedsoheil-hosseini@uiowa.edu
#####End Set Scheduler Configuration Directives#####


#####Resource Selection Directives#####
#See the HPC wiki for complete resource information: https://wiki.uiowa.edu/display/hpcdocs/Argon+Cluster
#Select the queue to run in
##$ -q IHPC
#$ -q all.q ############################################################################

#Select the number of slots the job will use
#$ -pe smp 20 ############################################################################ 

#Indicate that the job requires a GPU
#$ -l gpu=true

#Sets the number of requested GPUs to 1
#$ -l ngpus=1 ############################################################################

#Indicate that the job requires a mid-memory (currently 256GB node)
##$ -l mem_256G=true ############################################################################

#Indicate the CPU architecture the job requires
##$ -l cpu_arch=broadwell

#Specify a data center for to run the job in
##$ -l datacenter=LC

#/bin/echo Running on compute node: `hostname`.

#Specify the high speed network fabric required to run the job
##$ -l fabric=omnipath
#####End Resource Selection Directives#####


#####Begin Compute Work#####
#Print information from the job into the output file
/bin/echo Running on compute node: `hostname`.
/bin/echo In directory: `pwd`
/bin/echo Starting on: `date`

#Sleep (wait and do nothing) for 60 seconds
#sleep 60
#sleep 5m

#Print the end date of the job before exiting
echo Now it is: `date`

python3 ../../unet3d/scripts/train.py --config_filename ./brats_config.json --model_filename ./brats_unet3d_baseline.h5 \
--training_log_filename brats_baseline_training_log.csv --nthreads 20 --ngpus 1 --fit_gpu_mem 2

#####End Compute Work#####
