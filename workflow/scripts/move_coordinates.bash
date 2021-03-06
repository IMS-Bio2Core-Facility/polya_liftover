#!/bin/bash

set -e -x

# Get parameters from snakemake
while getopts ":b:g:o:" opt; do
  case "$opt" in
    b) BEDFILE="$OPTARG" ;;
    g) GTF="$OPTARG" ;;
    o) OUT="$OPTARG" ;;
    :) echo 'All arguments must be provided' >&2
       exit 1 ;;
    \?) echo 'An illegal option was provided' >&2
        exit 1 ;;
  esac
done

# We want to iteratively modify while preserving the original file
# So we create a tmpfile, modify that, then move it to output
TMPGTF=$(mktemp)
cp $GTF $TMPGTF

# Read Bedfile, splitting on expected fields
while read -r CHR NEWSTART NEWEND NAME; do
    # Extract current end from GTF
    OLDEND=$(awk -v name="$NAME" '$3 == "gene" && $0 ~ name {print $5}' "$TMPGTF")
    # Increment NEWEND as GTF is 1-indexed, while BED is 0-indexed
    ((NEWEND+=1))
    # For anyline that contains `name`
    # If field 5 (feature end) is OLDEND,
    # Replace with NEWWEND
    # Also, we don't want to use sponge, so old fashioned tmp files
    TMPFILE=$(mktemp)
    awk \
      -v oldend="$OLDEND" \
      -v newend="$NEWEND" \
      -v name="$NAME" \
      'BEGIN{FS=OFS="\t"} $5 == oldend && $0 ~ name {$5 = newend} 1' \
      "$TMPGTF" > "$TMPFILE" &&
    mv "$TMPFILE" "$TMPGTF"
done < "$BEDFILE"

mv "$TMPGTF" "$OUT"
