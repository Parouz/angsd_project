#!/bin/bash
#SBATCH --job-name=featureCounts
#SBATCH --output=featureCounts_%j.out
#SBATCH --error=featureCounts_%j.err
#SBATCH --partition=angsd_class
#SBATCH --mem=100G
#SBATCH --cpus-per-task=24
#SBATCH --time=12:00:00

# Activate your conda environment
source ~/.bashrc
conda activate angsd

# Define paths
PROJECT_DIR="/athena/angsd/scratch/par4012/project"
ALIGN_DIR="$PROJECT_DIR/project_outputs/aligned_reads"
GTF_FILE="$PROJECT_DIR/reference/gencode.v47.basic.annotation.gtf"
OUTFILE="$PROJECT_DIR/project_outputs/feature_counts/counts.txt"

# Run featureCounts with paired-end and stranded parameters
featureCounts -T 24 -p --countReadPairs \
  -s 2 \
  -a "$GTF_FILE" \
  -o "$OUTFILE" \
  --minOverlap 10 \
  "$ALIGN_DIR"/Ctrl_*_Aligned.sortedByCoord.out.bam \
  "$ALIGN_DIR"/SLE_*_Aligned.sortedByCoord.out.bam