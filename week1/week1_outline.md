# Outline of goals for week 1

Our main goal for week 1 is to get used to using SLURM on the Harvard cluster, and to learn about read mapping with bwa. We will end the week by generating our first real analysis of the summer, mapping the short read sequencing data from one individual to the reference genome.

## Step 1: Running a SLURM script

The first goal is just to run a very simple SLURM script. The file `helloworld.sh` is a SLURM script that submits a job that will make an empty text file called hello_world.txt in the directory you run the script from, using the UNIX command `touch hello_world.txt`.

Look at this script, and the explanation file, and try to get a sense of what each part does. Then, from the cluster, submit the script by typing `sbatch helloworld.sh`.

The `sbatch` command submits scripts to the cluster. You can monitor the progress of scripts using `squeue` or `sacct`. If you type these right after submitting the script, you will probably see it pending for a moment before it runs. Once the script finishes, you should see the hello_world.txt file in your directory.

## Step 2: Modifying a SLURM scripts

The next step is to modify the `helloworld.sh` to do something else. You will leave the slurm commands unchanged, but remove the `touch hellow_world.txt` command and replace it with `ls -l $HOME > homedir_contents.txt`. Try this command in the command line and see what it does, then delete the homedir_contents.txt file.

Then, make a copy of the helloworld.sh script, and replace the touch command with the ls command above. Now, submit this script using `sbatch`, and after a few moments you should see the homedir_contents.txt file appear. Remember you can use `squeue` to see the status of your job.

## Step 3: Running BWA on a test dataset

The next step is run the read mapping program BWA on a test dataset. We'll do this first interactively, and then make it a SLURM script.
-to do interactive jobs, use srun (Sara add details)
-to run BWA, first need to make a reference file (Sara add details)
-then run bwa mem to map reads (Sara add details)

This is an example on a small test dataset that won't take much time to finish. You can use the same slurm script (helloworld.sh). Make a copy, and delete the touch command, and then add the bwa commands exactly as you typed them in the interative node. Remember each bash command needs to be on a new line.

Now, run this mapping script with sbatch. You should get the same output as when you did this interactively.

## Step 4: Running BWA on real data

-Sara add details

Congratulations, you are a bioinformaticist now!
