#!/bin/bash
#SBATCH -p shared
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem 1000
#SBATCH -t 30
#SBATCH -o slurm.%N.%j.out
#SBATCH -e slurm.%N.%j.err

# submit this script from your home directory by typing sbatch helloworld.sh

touch hello_world.txt
