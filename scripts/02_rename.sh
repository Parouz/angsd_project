#!/bin/bash

# Define the mapping based on your provided metadata
declare -A sample_map
sample_map=( 
    [SRR539372]="Ctrl"
    [SRR539373]="Ctrl"
    [SRR539374]="Ctrl"
    [SRR539375]="Ctrl"
    [SRR539376]="Ctrl"
    [SRR539377]="Ctrl"
    [SRR539378]="Ctrl"
    [SRR539379]="Ctrl"
    [SRR539380]="Ctrl"
    [SRR539381]="Ctrl"
    [SRR539382]="Ctrl"
    [SRR539383]="Ctrl"
    [SRR539384]="Ctrl"
    [SRR539385]="Ctrl"
    [SRR539842]="SLE"
    [SRR539843]="SLE"
    [SRR539844]="SLE"
    [SRR539845]="SLE"
    [SRR539846]="SLE"
    [SRR539847]="SLE"
    [SRR539848]="SLE"
    [SRR539849]="SLE"
    [SRR539850]="SLE"
    [SRR539851]="SLE"
    [SRR539852]="SLE"
    [SRR539853]="SLE"
    [SRR539854]="SLE"
)

# Initialize counters
declare -A counter
counter["Ctrl"]=1
counter["SLE"]=1

# Loop through each FASTQ file and rename it
for file in SRR*_*.fastq.gz; do
    # Extract base SRR ID and read direction (_1 or _2)
    base=$(echo "$file" | cut -d'_' -f1)
    direction=$(echo "$file" | cut -d'_' -f2 | cut -d'.' -f1)

    # Determine the disease status from sample_map
    if [[ -n "${sample_map[$base]}" ]]; then
        group="${sample_map[$base]}"
        sample_number="${counter[$group]}"  # Assign current counter
        if [[ "$direction" == "1" ]]; then
            new_name="${group}_${sample_number}_f.fastq.gz"
        else
            new_name="${group}_${sample_number}_r.fastq.gz"
        fi

        # Rename the file
        mv "$file" "$new_name"
        
        # Increment counter for that group
        counter[$group]=$((counter[$group] + 1))
    fi
done

echo "Renaming complete!"