# Outline of goals for week 2

The main goal for week 2 is to clean up the output from week 1 by producing one clean BAM file per individual. Computing coverage and creating a histogram of the coverage for each scaffold would be a bonus! We can see how the week goes and adjust as necessary. 

## Step 1: Test out SAMtools commands from Bioinformatics Coffee Hour 

Using a SAM file from your week 1 output (or SAMEA3532871_mtv2.sam if your week1 data hasn't finished running yet), set up two slurm scripts to test two different SAMtools commands that Danielle covered in the coffee hour demo last week. A useful command to know is how to convert a SAM file into a BAM file (a compressed version of a SAM file). You'll need to load the SAMtools module as the first step in your slurm script (after the #SBATCH commands): 

`module load samtools/1.10-fasrc01`

Then you'll need the SAMtools `view` command to convert your SAM file to a BAM file, replacing "outfile" and "infile" with the appropriate names ie/ replace "infile.sam" with your input SAM file name and "outfile.bam" with what you want the output BAM file to be called (preferrably the same name as your SAM file so you know which BAM is associated with which SAM individual). 

`samtools view -b -h -o outfile.bam infile.sam`  

eg/ for the test file, this command would like like  
`samtools view -b -h -o SAMEA3532871.bam SAMEA3532871_mtv2.sam`  

In a second script (afer #SBATCH commands and `module load samtools/1.10-fasrc01`), let's pull some statistics from our BAM file with the SAMtools `stats` command: 

`samtools stats infile.bam`

Check your ouput from the `stats` command (hint: use `less` or `head`) to make sure it worked. If you're interested in what the stats are, a description of the output sections are listed [here](http://www.htslib.org/doc/samtools-stats.html). But this is pretty overkill so let's use a little trick to just get a summary.  

`cat slurm.out | grep ^SN | cut -f 2-`  

## Step 2: Clean up the SAMs and convert to BAMs

Before we can create a single file per individual, we want to convert them to BAM files and clean them up. We're going to do this in six steps that will be initiated by using a for loop in a slurm script. Remember, you'll need the #SBATCH commands and module load command in your script before your for loop. 

`for file in *.sam;`  
`do`  
  `samtools view -b -h -o $file.bam $file.sam`  
  `samtools sort -o $file.sorted.bam $file.bam`  
  `samtools index $file.sorted.bam`  
  `samtools fixmate -r -m -O bam $file.sorted.bam $file.fm.bam`  
  `samtools markdup -r -s -f $file.stats.out $file.fm.bam $file.final.bam`  
  `samtools quickcheck $file.final.bam`  
`done`  

There is a lot in this loop, so let's unpack each command (more info can be found in the [SAMtools manual page](http://www.htslib.org/doc/samtools.html).

1. `samtools view` converts between SAM/BAM files.
- `-b` option sets the output format to BAM
- `-h` includes the header in the output
- `-o` sets the name of the output file

2. `samtools sort` sorts SAM/BAM files
- `-o` sets the name of the output file

3. `samtools index` indexes SAM/BAM files - the only input for `samtools index` is the input file to be indexed

4. `samtools fixmate` fills in mate coordinates (necessary step before `markdup`) 
- `-r` removes unmapped reads
- `-m` adds mate score tags to be used by `markdup` 
- `-O` sets the format for the output file

5. `samtools markdup` will mark any duplicate alignments in a coordinate sorted file
- `-r` removes duplicate reads
- `s` prints out some basic stats 
- `-f` writes the stats to a file  

6. `samtools quickcheck` will do a brief validation of of the input file - the only input here is the file to be checked over  

Check over the output and error logs to see if there are any issues with the files that have been produced (go through this with Sara). If the files look good, we can delete the SAM files and any temporary files that may have been produced in this process. 

## Step 3: Merge your BAMs into a single BAM per individual

Now we have a single, clean BAM file from each of our initial SAM files, but we still have multiple BAMs for each individual and we need to combine these together to create a single BAM for each individual. You'll want to create slurm scripts (with #SBATCH and `module load` commands) to do this.  

Khaleb, since you will only have 1-2 BAMs per individual, you can use the `samtools merge` command like this:  

`samtools merge outfile.bam infile1.bam infile2.bam ... infileN.bam`  

Dymon, since you have many more BAMs per individual, we'll need to make a list of BAMs per individual and use that as input for the `samtools merge` command, like this: 

`samtools merge -b infiles.list outfile.bam`  

And just like that, you have one BAM per individual and we're ready to calculate coverage! 
