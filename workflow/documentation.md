# Technical Documentation

What follows is a technical documentation of each step in the pipeline.

The steps `get_whitelist`,
`get_gtf`,
`get_fa`,
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

[fastqc]:
[multiqc]:
[star]: https://github.com/alexdobin/STAR "STAR"
[wrappers]: https://snakemake-wrappers.readthedocs.io/en/stable/ "Snakemake Wrappers Repository"
[bps]: https://snakemake.readthedocs.io/en/stable/snakefiles/modularization.html#snakefiles-wrappers "Snakemake Wrappers"
[star_wrapper]: https://snakemake-wrappers.readthedocs.io/en/stable/wrappers/star.html "STAR Wrapper"
[STARSolo]: https://github.com/alexdobin/STAR "STARSolo"
