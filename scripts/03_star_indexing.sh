#!/bin/bash
#SBATCH --job-name=star_index
#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=50G
#SBATCH --time=06:00:00
#SBATCH --output=star_indexing.log
#SBATCH --error=star_indexing.err

# Activate condo environment
conda activate angsd

# Define paths
GENOME_DIR="/athena/angsd/scratch/par4012/project/reference/STAR_index"
GENOME_FASTA="/athena/angsd/scratch/par4012/project/reference/GRCh38.primary_assembly.genome.fa"
GTF_FILE="/athena/angsd/scratch/par4012/project/reference/gencode.v47.basic.annotation.gtf"

# Create genome index directory
mkdir -p $GENOME_DIR

# Run STAR genomeGenerate
STAR --runMode genomeGenerate \
     --runThreadN 20 \
     --genomeDir $GENOME_DIR \
     --genomeFastaFiles $GENOME_FASTA \
     --sjdbGTFfile $GTF_FILE \
     --sjdbOverhang 99