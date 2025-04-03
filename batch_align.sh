#!/bin/bash
#SBATCH --job-name=star_align_raw
#SBATCH --output=star_align_raw.out
#SBATCH --error=star_align_raw.err
#SBATCH --partition=angsd_class
#SBATCH --cpus-per-task=20
#SBATCH --mem=100G
#SBATCH --time=24:00:00

# Activate conda environment
source ~/.bashrc
conda activate angsd

# Define paths
PROJECT_DIR="/athena/angsd/scratch/par4012/project"
DATA_DIR="$PROJECT_DIR/data"
OUT_DIR="$PROJECT_DIR/aligned_reads"
GENOME_DIR="$PROJECT_DIR/reference/STAR_index"

# Align Ctrl_2 to Ctrl_14
for i in {2..14}; do
  FORWARD="${DATA_DIR}/Ctrl_${i}_f.fastq.gz"
  REVERSE="${DATA_DIR}/Ctrl_${i}_r.fastq.gz"
  PREFIX="${OUT_DIR}/Ctrl_${i}_"

  echo "Aligning Ctrl_${i}..."

  STAR --runThreadN 20 \
       --genomeDir $GENOME_DIR \
       --readFilesIn $FORWARD $REVERSE \
       --readFilesCommand zcat \
       --outFileNamePrefix $PREFIX \
       --outSAMtype BAM SortedByCoordinate \
       --quantMode GeneCounts \
       --outFilterMultimapNmax 1 \
       --outFilterMismatchNoverReadLmax 0.04 \
       --alignSJoverhangMin 8
done

# Align SLE_2 to SLE_13
for i in {2..13}; do
  FORWARD="${DATA_DIR}/SLE_${i}_f.fastq.gz"
  REVERSE="${DATA_DIR}/SLE_${i}_r.fastq.gz"
  PREFIX="${OUT_DIR}/SLE_${i}_"

  echo "Aligning SLE_${i}..."

  STAR --runThreadN 20 \
       --genomeDir $GENOME_DIR \
       --readFilesIn $FORWARD $REVERSE \
       --readFilesCommand zcat \
       --outFileNamePrefix $PREFIX \
       --outSAMtype BAM SortedByCoordinate \
       --quantMode GeneCounts \
       --outFilterMultimapNmax 1 \
       --outFilterMismatchNoverReadLmax 0.04 \
       --alignSJoverhangMin 8
done