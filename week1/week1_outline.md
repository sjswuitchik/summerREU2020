# Outline of goals for week 1

Our main goal for week 1 is to get used to using SLURM on the Harvard cluster, and to learn about read mapping with bwa. We will end the week by generating our first real analysis of the summer, mapping the short read sequencing data from one individual to the reference genome.

## Step 1: Running a SLURM script

The first goal is just to run a very simple SLURM script. The file `helloworld.sh` is a SLURM script that submits a job that will make an empty text file called hello_world.txt in the directory you run the script from, using the UNIX command `touch hello_world.txt`.

Look at this script, and the explanation file, and try to get a sense of what each part does. Then, from the cluster, submit the script by typing `sbatch helloworld.sh`.

The `sbatch` command submits scripts to the cluster. You can monitor the progress of scripts using `squeue` or `sacct`. If you type these right after submitting the script, you will probably see it pending for a moment before it runs. Once the script finishes, you should see the hello_world.txt file in your directory.

## Step 2: Modifying a SLURM scripts

The next step is to modify the `helloworld.sh` to do something else. You will leave the slurm commands unchanged, but remove the `touch hello_world.txt` command and replace it with `ls -l $HOME > homedir_contents.txt`. Try this command in the command line and see what it does, then delete the homedir_contents.txt file by typing `rm homedir_contents.txt`

Then, make a copy of the helloworld.sh script, and replace the touch command with the ls command above. Now, submit this script using `sbatch`, and after a few moments you should see the homedir_contents.txt file appear. Remember you can use `squeue` to see the status of your job.

## Step 3: Running BWA on a test dataset

The next step is run the read mapping program BWA on a test dataset. We'll do this first interactively, and then as a SLURM script.  

### 3a. Running an interactive job  
To request and run an interactive job, use `srun --pty -p test -t 40 --mem 3000 /bin/bash`. You'll see that your request has been queued, then that it's been allocated. Now you can type directly on the command line. You'll be using the data in the `data` directory (summerREU2020/week1/data). Copy the two fastq files to your working directory (eg/ $HOME) then load the BWA module (like loading packages in R):   
`module load bwa/0.7.17-fasrc01` 

Now, you'll need to get the reference genome from NCBI, which you can get by typing:  
`wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/008/822/105/GCF_008822105.2_bTaeGut2.pat.W.v2/GCF_008822105.2_bTaeGut2.pat.W.v2_genomic.fna.gz`  
Then we need to make an index of the reference genome to help BWA efficiently search the genome while it's aligning sequences. Do that by typing:  
`bwa index -p taeGut GCF_008822105.2_bTaeGut2.pat.W.v2_genomic.fna.gz`  
  
Next, we can use BWA to align the reads in our sample fastq files to the reference genome. This will output a SAM file for the sample. Let's do that by typing:  
`bwa mem -t 1 taeGut ERR1013161_1.fastq.gz ERR1013161_2.fastq.gz > ERR1013161.sam #2> taeGut.log`  
  
### 3b. Running BWA as a slurm script  
This is an example on a small test dataset that won't take much time to finish. You can use the same architecture of the helloworld.sh slurm script to now run BWA throught the job scheduler. Make a copy of helloworld.sh, delete the touch command, and then add the bwa commands exactly as you typed them in the interative node. Remember each bash command needs to be on a new line.

Now, run this mapping script with `sbatch <script file name>`. You should get the same output as when you did this interactively.

## Step 4: Running BWA on real data
There are four directories in `/n/holyscratch01/informatics/swuitchik/summer2020REU/duck_data/` that contain the duck data. The four species you'll be working with this summer are:  
1. Black-headed duck (Heteronetta atricapilla), short code `hetAtr` - this is the brood parasitic species!  
2. African pygmy goose (Nettapus auritus), short code `netAur`  
3. Ruddy duck (Oxyura jamaicensis), short code `oxyJam`  
4. Freckled duck (Stictonetta naevosa), short code `stiNae`  

Dymon, you'll be working with hetAtr, which has more data for the species - Khaleb, you'll be working with the other three species, which don't have as much data per species but you have more species to work with!   

Within each species directory, there are multiple fastq files and a directory called `refGenome` that contains the reference genome that we've made (downloaded from NCBI). You'll want to use the fasta file in the refGenome directory as your reference genome and the fastq files as the sequences you align to the reference genome. Note that these are all 'paired end' reads, which means we have two fastq files per individual. 

Congratulations, you are a bioinformatician now!
