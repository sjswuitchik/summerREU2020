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

Now that we're working in R, feel free to go back to the demo code from the virtualREU session to familiarize yourself with data manipulation (and to grab the R cheat sheets if you haven't already). With the data you now have for each individual, you can start to explore the coverage relationships between the male and female samples - identify which scaffolds have approximately twice the coverage in males as the same scaffolds in females (remember that male ZZ sex-linked scaffolds will have approx. twice the coverage of a ZW female). Khaleb, we've already renamed your files so you know which the male and female are in your data. Dymon, there is a spreadsheet uploaded under week 3 (bgi2reu_ids.csv) that has the sex designation - we have definitive males (coded as m) and unknown possibly females (coded as uf) for the hetAtr data.

Next, we'll want to create a BED file of the scaffolds of interest and write it out from R. A BED file is just a tab-delimited text file that defines genomic features. The first column will be the scaffold name, the second column will be the start position of the scaffold, and the third column will be the end position of the scaffold. BED start and end positions are on a different coordinate system from some other file formats, so once you have the (scaffold)-(start)-(end) columns, you'll want to make a new column where the values are (start - 1). Your new table should then look like this: (scaffold)-(start)-(end)-(start-1). Select just the (scaffold), (start-1), and (end) columns, rename (start-1) to just (start), and write this out as a tab-delimited BED file from R.  

Useful commands for this step that we covered in the intro to R virtualREU session are `library` (to load the tidyverse package), `mutate` (to make new columns with new values), `select` (to choose which columns to include), `rename` (to rename columns), and `write_csv` (to export the final files with the proper delimiter and file extension).  

## Step 4: Run SAMtools depth on specific scaffolds  

Now that you have identified specific scaffolds that could be sex-linked, use `sftp` to transfer your new BED files to the cluster and run `samtools depth` on the scaffolds of interest. SAMtools `depth` is a more complete look at coverage than SAMtools `coverage` and allows you to use a BED file as input for what positions and scaffolds you're interested in. The command for a single individual would be something like this: `samtools depth -b scaffolds.bed -o output.txt input.bam`
