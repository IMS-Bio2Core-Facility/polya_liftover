# Technical Documentation

What follows is a technical documentation of each step in the pipeline.

The steps `get_whitelist`,
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
so we must subtract one from the passed values.tool can take several types of inputs,
it proves easiest to construct and use a [BED][bed] file,
as it is their default.
BED files are 0-indexed,
not 1-indexed like PolyA_DB and GTF,
so we must subtract one from the passed values.

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
splitting he fields into variables.
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

## Rule: index_genome

Uses [STAR][star] `--runMode genomeGenerate`  to generate the counts matrix for each sample.

Relatively straightforward:
uses the GTF and FA specified in the config file to produce a reference genome for STAR.
Otherwise, the parameters supplied are the defaults,
recommended by STAR.

For both this rule and [Rule: star](#rule-star)
**do not** use the [Snakemake wrapper][wrappers].
Though this breaks from [Snakemake best practices][bps],
the most recent STAR wrapper [does not use][star_wrapper]
the most recent version of STAR.
Additionally,
the number of extra parameters required to run `STARSolo`
makes the use of the wrapper challenging.

## Rule: star

Uses [STAR][star] `--runMode alignReads --soloType CB_UMI_Simple` to prdouce the count matrix.

Runs "STARSolo" on the genome above and the input FastQs.
A whitelist is necessary,
so the one specified in the config file is used.
Be sure to use the one that suits the type of data (ie 10x, etc).
The parameters used in this call are optimised for 10x data
(which is what my sequencing core tends to use),
though they can be easily changed in the rule.
Please see [here][starsolo] for a full guide to the possible parameters.

[fastqc]: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/ "FastQC"
[multiqc]: https://multiqc.info/docs/ "MultiQC"
[polyadb]: https://exon.apps.wistar.org/polya_db/v3/ "PolyA_DBv3"
[bed]: https://genome.ucsc.edu/FAQ/FAQformat.html#format1 "BED File Format"
[liftover]:  https://genome.ucsc.edu/cgi-bin/hgLiftOver "LiftOver"
[awk]: https://www.gnu.org/software/gawk/manual/gawk.html "awk"
[shell]: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html "Snakemake Shell"
[getopts]: https://www.freebsd.org/cgi/man.cgi?query=getopt&sektion=1 "getopts"
[star]: https://github.com/alexdobin/STAR "STAR"
[wrappers]: https://snakemake-wrappers.readthedocs.io/en/stable/ "Snakemake Wrappers Repository"
[bps]: https://snakemake.readthedocs.io/en/stable/snakefiles/modularization.html#snakefiles-wrappers "Snakemake Wrappers"
[star_wrapper]: https://snakemake-wrappers.readthedocs.io/en/stable/wrappers/star.html "STAR Wrapper"
[STARSolo]: https://github.com/alexdobin/STAR "STARSolo"
