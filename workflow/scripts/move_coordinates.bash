#!/bin/bash

set -e

# Get parameters from snakemake
while getopts "b:g:o:" opt; do
  case "$opt" in
    b)  BEDFILE="$OPTARG"
      ;;
    g)  GTF="$OPTARG"
      ;;
    o)  OUT="$OPTARG"
      ;;
  esac
done

# Read Bedfile, splitting on expected fields
while read -r CHR NEWSTART NEWEND NAME; do
    # Extract current end from GTF
    OLDEND=$(awk -v name="$NAME" '$3 == "gene" && $0 ~ name {print $5}' "$GTF")
    # Increment NEWEND as GTF is 1-indexed, while BED is 0-indexed
    ((NEWEND+=1))
    # For anyline that contains `name`
    # If field 5 (feature end) is OLDEND,
    # Replace with NEWWEND
    awk \
      -v oldend="$OLDEND" \
      -v newend="$NEWEND" \
      -v name="$NAME" \
      'BEGIN{FS=OFS="\t"} $5 == oldend && $0 ~ name {$5 = newend} 1' \
      "$GTF" > "$OUT"
done < "$BEDFILE"
