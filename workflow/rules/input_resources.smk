# Rules for moving inputs to necessary locations/formats


rule unpack_bcl2fastq:
    input:
        **get_bcl_results(),
    output:
        bcl2fastq="results/bcl2fastq/Stats/Stats.json",
    log:
        "results/logs/unpack_bcl2fastq/unpack_bcl2fastq.log",
    benchmark:
        "results/benchmarks/unpack_bcl2fastq/unpack_bcl2fastq.txt"
    shell:
        "unzip "
        "{input.bcl_zip} "
        "-d results/bcl2fastq "
        "&> {log}"


rule clean_names:
    input:
        get_fastqs,
    output:
        "data/{sample}_S1_L00{lane}_{read}_001.fastq.gz",
    log:
        "results/logs/clean_names/{lane}_{sample}_{read}.log",
    benchmark:
        "results/benchmarks/clean_names/{lane}_{sample}_{read}.txt"
    shell:
        "mv "
        "{input} "
        "{output} "
        "&> {log}"
