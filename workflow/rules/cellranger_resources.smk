# Gather input resources for STAR


rule get_cellranger:
    output:
        cr=directory("resources/cellranger"),
        bin="resources/cellranger/bin/cellranger",
    params:
        url=config["get_cellranger"]["url"],
    log:
        "results/logs/get_cellranger/get_cellranger.log",
    benchmark:
        "results/benchmarks/get_cellranger/get_cellranger.txt"
    shell:
        "wget --no-verbose -O- {params.url} | "
        "tar -xzf - -C resources && "
        "rm -rf resources/cellranger.tar.gz && "
        "mv resources/cellranger-* resources/cellranger "


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
        "gunzip > {output.fa} "
        "2> {log}"