#!/bin/bash
#SBATCH -p shared
#SBATCH -N 1
#SBATCH -n 1 
#SBATCH --mem 1000
#SBATCH -t 0-30:00
#SBATCH -o slurm.%N.%j.out
#SBATCH -e slurm.%N.%j.err

# submit this script from your home directory 

echo "hello world" > world.out
