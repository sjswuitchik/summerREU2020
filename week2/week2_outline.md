# Outline of goals for week 2

The main goal for week 2 is to clean up the output from week 1 by producing one clean BAM file per individual. Computing coverage and creating a histogram of the coverage for each scaffold would be a bonus! We can see how the week goes and adjust as necessary. 

## Step 1: Test out SAMtools commands from Bioinformatics Coffee Hour 

Using a SAM file from your week 1 output, set up two slurm scripts to test two different SAMtools commands that Danielle covered in the coffee hour demo last week. A useful command to know is how to convert a SAM file into a BAM file (a compressed version of a SAM file). 
You'll need to load the SAMtools module as the first step in your slurm script (after the #SBATCH commands): 

`module load samtools/1.10-fasrc01`

Then you'll need the SAMtools `view` command to convert your SAM file to a BAM file, replacing "outfile" and "infile" with the appropriate names ie/ replace "infile.sam" with your input SAM file name and "outfile.bam" with what you want the output BAM file to be called (preferrably the same name as your SAM file so you know which BAM is associated with which SAM individual). 

`samtools view -b -h -o outfile.bam infile.sam`

In a second script (afer #SBATCH commands and `module load samtools/1.10-fasrc01`), let's pull some statistics from our BAM file with the SAMtools `stats` command: 

`samtools stats infile.bam`

Check your ouput from the `stats` command (hint: use `less` or `head`) to make sure it worked. If you're interested in what the stats are, a description of the output sections are listed [here](http://www.htslib.org/doc/samtools-stats.html)


