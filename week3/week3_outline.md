# Outline of goals for week 3

The main goal for week 3 is to identify scaffolds that could be associated with sex chromosomes by calculating coverage for all individuals and comparing coverage between males and females. 

## Step 1: Test ouf SAMtools command on trial data

Using the BAM file in the week 3 directory (test.sorted.bam), use the `coverage` command to calculate some useful summary statistics for each scaffold. You don't need to run this as a slurm script, it will be pretty quick to run in the terminal.  

`samtools coverage test.sorted.bam > test.out`  

Look through the test.out file (or don't redirect it to an out file and just look at it in your terminal) and use the [SAMtools manual on coverage](http://www.htslib.org/doc/samtools-coverage.html) to make sure you understand what the fields are.  

## Step 2: Calculate coverage for each individual  

We'll need to look at the coverage for all individuals, which we can do now that we have a BAM for each individual (output from week 2). 
