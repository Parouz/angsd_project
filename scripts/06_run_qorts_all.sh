#!/bin/bash
#SBATCH --job-name=qorts_all
#SBATCH --output=qorts_all_%j.out
#SBATCH --error=qorts_all_%j.err
#SBATCH --partition=angsd_class
#SBATCH --cpus-per-task=24
#SBATCH --mem=100G
#SBATCH --time=24:00:00

# Activate conda environment
source ~/.bashrc
conda activate qorts

# Define paths
PROJECT_DIR="/athena/angsd/scratch/par4012/project"
BAM_DIR="$PROJECT_DIR/project_outputs/aligned_reads"
GTF="$PROJECT_DIR/reference/gencode.v47.basic.annotation.gtf"
QORTS_JAR="/athena/angsd/scratch/mef3005/share/envs/qorts/share/qorts-1.3.6-1/QoRTs.jar"
QORTS_OUT="$PROJECT_DIR/project_outputs/qorts_out"

# Loop over each BAM file and run QoRTs into its own folder
for bam in "$BAM_DIR"/*.bam; do
  sample=$(basename "$bam" .bam)
  out_dir="$QORTS_OUT/$sample"

  echo "Running QoRTs on $sample..."

  java -Xmx96G -jar "$QORTS_JAR" QC \
    --stranded \
    --generatePlots \
    "$bam" \
    "$GTF" \
    "$out_dir"
done