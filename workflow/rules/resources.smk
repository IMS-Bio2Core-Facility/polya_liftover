rule get_whitelist:
    params:
        url=config["get_whitelist"]["url"],
    output:
        wl="resources/whitelist.txt.gz",
    log:
        "results/logs/get_whitelist/get_whitelist.log",
    benchmark:
        "results/benchmarks/get_whitelist/get_whitelist.txt"
    shell:
        "wget "
        "--no-verbose "
        "-O {output.wl} "
        "{params.url} "
        "&> {log}"


rule get_gtf:
    # No env provide as runs in container
    params:
        url=config["get_gtf"]["url"],
    output:
        gtf="resources/genome.gtf",
    log:
        "results/logs/get_gtf/get_gtf.log",
    benchmark:
        "results/benchmarks/get_gtf/get_gtf.txt"
    shell:
        "wget "
        "--no-verbose -O- "
        "{params.url} | "
        "gunzip > {output.gtf} "
        "2> {log}"


rule get_fa:
    params:
        url=config["get_fa"]["url"],
    output:
        fa="resources/genome.primary_assembly.fa",
    log:
        "results/logs/get_fa/get_fa.log",
    benchmark:
        "results/benchmarks/get_fa/get_fa.txt"
    shell:
        "wget "
        "--no-verbose -O- "
        "{params.url} | "
        "gunzip > {output.fa}"
        "2> {log}"


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
