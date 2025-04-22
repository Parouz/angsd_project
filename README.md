# Final Project: Transcriptomic Profiling of SLE in CD4⁺ T Cells

This repository contains the complete pipeline, quality control outputs, and results for a transcriptomic analysis of CD4⁺ T cells from systemic lupus erythematosus (SLE) patients and healthy controls. The project aims to investigate differential gene expression and biological pathway enrichment to uncover immune dysregulation associated with SLE.

## Project Organization

The repository is structured into logically grouped folders and files, as follows:

### `graphics/`
This folder contains all QC and result plots generated throughout the analysis, including:

- FastQC and alignment QC (e.g., `adapter_content.png`, `general_statistics.png`)
- STAR alignment and gene count plots (e.g., `star_alignment_plot.png`, `star_gene_counts.png`)
- QoRTs-based splice and alignment visualizations (e.g., `qorts_splice_events.png`, `qorts_alignments.png`)
- FeatureCounts barplots (e.g., `featureCounts_assignment_plot.png`)
- Downstream exploratory and statistical visualizations (e.g., `Ctrl_1_SLE_11_IGV.png`, `per_base_sequence_content.png`)

### `IGV_files/`
Contains `.bam` and `.bai` alignment files extracted for the **ISG15** gene region in representative Ctrl and SLE samples. These are used for visual inspection in IGV:

- `Ctrl_1.ISG15.bam`, `Ctrl_1.ISG15.bam.bai`
- `SLE_11.ISG15.bam`, `SLE_11.ISG15.bam.bai`

### `revigo/`
Includes input and script files for generating semantic simplifications of enriched GO terms using the Revigo web server:

- `revigo_input.txt`: GO term enrichment results used as input
- `Revigo_BP_TreeMap.R`: R script to generate Revigo treemaps from Revigo's output

### `scripts/`
Shell scripts for end-to-end RNA-seq preprocessing, alignment, and quantification using STAR, QoRTs, and featureCounts. Each script is sequentially numbered for clarity:

- `01_sra_download.sh`: Download RNA-seq data from SRA
- `02_rename.sh`: Rename FASTQ files
- `03_star_indexing.sh`: STAR genome index creation
- `04_batch_align.sh`: STAR alignment with optimized parameters
- `05_index_bams.sh`: Index aligned BAMs
- `06_run_qorts_all.sh`: Run QoRTs for quality control
- `07_run_featurecounts.sh`: Run featureCounts for read quantification

### `counts.txt`
The raw gene count matrix output from `featureCounts`, used for differential expression analysis with DESeq2.

### `project_report_par4012.Rmd`
The main RMarkdown file containing all code, results, visualizations, and written analysis. This serves as the primary report and includes all figures and interpretation.

### `project_report_par4012.html`
The rendered HTML version of the report for easy viewing in a browser.
