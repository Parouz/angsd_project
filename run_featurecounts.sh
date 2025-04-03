#!/bin/bash
#SBATCH --job-name=featureCounts
#SBATCH --output=featureCounts_%j.out
#SBATCH --error=featureCounts_%j.err
#SBATCH --mem=100G
#SBATCH --cpus-per-task=24
#SBATCH --time=4:00:00

# Load or activate the conda environment if necessary
# module load subread or source activate env
source ~/.bashrc
conda activate angsd

# Define paths
PROJECT_DIR="/athena/angsd/scratch/par4012/project"
ALIGN_DIR="$PROJECT_DIR/aligned_reads"
GTF_FILE="$PROJECT_DIR/reference/gencode.v47.basic.annotation.gtf"
OUTFILE="$PROJECT_DIR/feature_counts/counts.txt"

# Run featureCounts on all Ctrl and SLE BAM files except for Ctrl_1 and SLE_1
featureCounts -T 24 -p \
  -a "$GTF_FILE" \
  -o "$OUTFILE" \
  --minOverlap 10 \
  "$ALIGN_DIR"/Ctrl_*_Aligned.sortedByCoord.out.bam \
  "$ALIGN_DIR"/SLE_*_Aligned.sortedByCoord.out.bam