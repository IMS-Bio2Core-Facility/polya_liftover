rule fastqc:
    input:
        fastq="data/{sample}_S1_L00{lane}_{read}_001.fastq.gz",
    output:
        html="results/fastqc/{lane}_{sample}_{read}.html",
        zip="results/fastqc/{lane}_{sample}_{read}_fastqc.zip",
    log:
        "results/logs/fastqc/{lane}_{sample}_{read}.log",
    benchmark:
        "results/benchmarks/fastqc/{lane}_{sample}_{read}.txt"
    threads: 5
    wrapper:
        "0.80.2/bio/fastqc"


rule multiqc:
    input:
        **agg_fastqc_star(),
        bcl2fastq=rules.unpack_bcl2fastq.output.bcl2fastq,
    output:
        html=report(
            "results/multiqc/multiqc.html",
            caption="../reports/multiqc.rst",
            category="1. QC Metrics for Sequencing Reads",
        ),
    log:
        "results/logs/multiqc/multiqc.log",
    benchmark:
        "results/benchmarks/fastqc/multiqc.txt"
    wrapper:
        "0.80.2/bio/multiqc"
