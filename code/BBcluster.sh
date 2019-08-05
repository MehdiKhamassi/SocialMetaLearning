#! /bin/sh
#PBS -N BBschwei7qrcGrid
#PBS -o /home/khamassi/Data/NTUA/BBparallelOpti_grid02_model7kalmanqrc.out
#PBS -b /home/khamassi/Data/NTUA/BBparallelOpti_grid02_model7kalmanqrc.err
#PBS -m abe
#PBS -M khamassi@isir.upmc.fr
#PBS -l walltime=1000:00:00
#PBS -l nodes=1:ppn=30
#PBS -d /home/khamassi/Data/NTUA
cd /home/khamassi/Src/matlab-code/NTUA
/usr/local/bin/matlab -nodesktop -nosplash -r BBparallelOpti
