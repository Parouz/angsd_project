#!/bin/bash
#SBATCH --job-name=index_bams
#SBATCH --output=index_bams_%j.out
#SBATCH --error=index_bams_%j.err
#SBATCH --partition=angsd_class
#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=01:00:00

# Activate conda environment
source ~/.bashrc
conda activate angsd

# Loop through all BAM files and index them
for bam in *.bam; do
    echo "Indexing $bam"
    samtools index "$bam"
done