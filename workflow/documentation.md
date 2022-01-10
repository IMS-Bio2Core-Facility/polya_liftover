# Technical Documentation

What follows is a technical documentation of each step in the pipeline.

The steps `get_cellranger`,
`get_gtf`,
`get_fa`,
`get_9_to_10`,
`get_10_to_39`,
`unpack_bcl2fastq`,
and `clean_names` are not here covered,
as the simply move or rename files.

## Rule: fastqc

Runs [FastQC][fastqc] on all input FastQ files.

5 threads are used to increase the memory available per sample.

## Rule: multiqc

Aggregates various QC metrics using [MultiQC][multiqc].

For this pipeline,
metrics are collected from [Rule: fastqc](#rule-fastqc),
`Rule: unpack_bcl2fastq`,
and [Rule: star](#rule-star).

## Rule: convert_to_bed

Converts the given [PolyA_DB][polyadb] to a [BED][bed] file.

Though UCSC [LiftOver][liftover] tool can take several types of inputs,
it proves easiest to construct and use a [BED][bed] file,
as it is their default.
BED files are 0-indexed,
not 1-indexed like PolyA_DB and GTF,
so we must subtract 1 from the passed values.

## Rules: liftover_9to10 & liftover_10to39

Converts the given [PolyA_DB][polyadb] coordinates to `mm39`.

PolyA_DB provides coordinates from the `mm9` reference genome,
which was assembled in 2010.
To use this information on modern builds,
we must first convert to `mm10` -
as [LiftOver][liftover] cannot convert directly from `mm9` to modern builds -
before converting to the most recent `mm39`.
To do this,
liftover is simply run twice:

1. Converts from `mm9` to `mm10`
1. Converts from `mm10` to `mm39`, using the above output.

## Rules: mkgtf

Runs [cellranger][cr] `mkgtf` to filter the GTF.

This filters the provided GTF file to a reduced list
of relevant gene and transcript biotypes.
The list used is described in CellRanger's instructions for
[making a custom reference][ref_build].
This is a potential point of optimisation.
Currently,
all features are hardcoded.
One possibility would be to pass them as a list from the config file,
allowing the user to specify their own features,
should they desire.

## Rule: move_coordinates

Alter the downloaded GTF reference file.

Use the venerable [awk][awk] to modify the existing GTF.
This is **not** done inplace,
so the original remains for reference.

The necessary `awk` command can actually be passed as a one-liner,
making Snakemake's [shell][shell] directive theoretically possible.
However,
the command is pretty gnarly,
and nearly impossible to read,
in such a format.
Instead a shell script is used,
with Snakemake variables passed and parsed using [getopts][getopts].

Iteration occurs line-by-line over the input BED file,
splitting the fields into variables.
The current feature endpoint is extracted from field 5 of the GTF
in the line that contains the gene name and the feature type `gene`.
The new endpoint is incremented by 1 to account for the BED -> GTF conversion.
The old endpoint is replaced with the new enpoint in any line where:

1. The old endpoint is present and...
1. The gene name is present

This has the effect of altering the:

* Gene
* Transcript
* Final Exon
* 3' UTR

for the given gene.

## Rule: mkref

Uses [cellranger][cr] `mkref` to create the final reference.

Relatively straightforward:
uses the filtered, updated GTF,
and the provided FA to produce the necessary reference genome.

## Rule: count

Uses [cellranter][cr] `count` to create the count matrix.

Interestingly,
CellRanger does not seem to let you create the results in a sub-directory,
but Snakemake seems to create a non-empty directory at the specified results paths.
So
to get the cellranger results in the correct location,
after the run,
we delete the Snakemae created directory
and move the CellRanger created directory to its location.

Other notes on the passed parameters:

1. Secondary analysis is disabled.
1. Whether or not introns are included is set by the config file.
1. This iterates over samples by lane. This means that the lane can be tracked across sample, even when pooling.

[fastqc]: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/ "FastQC"
[multiqc]: https://multiqc.info/docs/ "MultiQC"
[polyadb]: https://exon.apps.wistar.org/polya_db/v3/ "PolyA_DBv3"
[bed]: https://genome.ucsc.edu/FAQ/FAQformat.html#format1 "BED File Format"
[cr]: https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger "CellRanger"
[ref_build]: https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/advanced/references "CellRanger Custom References"
[liftover]:  https://genome.ucsc.edu/cgi-bin/hgLiftOver "LiftOver"
[awk]: https://www.gnu.org/software/gawk/manual/gawk.html "awk"
[shell]: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html "Snakemake Shell"
[getopts]: https://www.freebsd.org/cgi/man.cgi?query=getopt&sektion=1 "getopts"
