# Outline of goals for week 3

The main goal for week 3 is to identify scaffolds that could be associated with sex chromosomes by calculating coverage for all individuals and comparing coverage between males and females. 

## Step 1: Test ouf SAMtools command on trial data

Using the BAM file in the week 3 directory (test.sorted.bam), use the `coverage` command to calculate some useful summary statistics for each scaffold. You don't need to run this as a slurm script, it will be pretty quick to run in the terminal.  

`samtools coverage test.sorted.bam > test.out`  

Look through the test.out file (or don't redirect it to an out file and just look at it in your terminal) and use the [SAMtools manual on coverage](http://www.htslib.org/doc/samtools-coverage.html) to make sure you understand what the fields are.  

## Step 2: Calculate coverage for each individual  

We'll need to look at the coverage for all individuals, which we can do now that we have a BAM for each individual (output from week 2). Create a slurm script (with #SBATCH commands and the module load command) that will calculate the coverage for each individual BAM and save the output into a file for each individual.  

`module load samtools/1.10-fasrc01`  
`samtools coverage infile.bam > infile.out`  

Pull those output files off the cluster using `sftp` (Sara will go through this with you one-on-one when you get to this step) to your local computer and we can start loading these data into R!  

## Step 3: Identify potential sex-chromosome-associated scaffolds 

Tim, I can come back to this later tonight

## Step 4: Run SAMtools depth on specific scaffolds