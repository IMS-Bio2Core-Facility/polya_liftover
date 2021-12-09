# Gather input resources for STAR


rule get_cellranger:
    output:
        cr=directory(f"resources/{CR_VERSION}"),
        bin=f"resources/{CR_VERSION}/bin/cellranger",
    params:
        url=config["get_cellranger"]["url"],
    log:
        "results/logs/get_cellranger/get_cellranger.log",
    benchmark:
        "results/benchmarks/get_cellranger/get_cellranger.txt"
    shell:
        "wget --no-verbose -O resources/cellranger.tar.gz '{params.url}' &> {log} && "
        "tar -xzf resources/cellranger.tar.gz -C resources &> {log} && "
        "rm -rf resources/cellranger.tar.gz "


rule get_gtf:
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


rule mkgtf:
    input:
        gtf=rules.get_gtf.output.gtf,
        bin=rules.get_cellranger.output.bin,
    output:
        gtf=temp("resources/genome.filtered.gtf"),
    log:
        "results/logs/mkgtf/mkgtf.log",
    benchmark:
        "results/benchmarks/mkgtf/mkgtf.txt"
    shell:
        "{input.bin} "
        "mkgtf "
        "{input.gtf} "
        "{output.gtf} "
        "--attribute=gene_biotype:protein_coding "
        "--attribute=gene_biotype:lincRNA "
        "--attribute=gene_biotype:antisense "
        "--attribute=gene_biotype:IG_LV_gene "
        "--attribute=gene_biotype:IG_V_gene "
        "--attribute=gene_biotype:IG_V_pseudogene "
        "--attribute=gene_biotype:IG_D_gene "
        "--attribute=gene_biotype:IG_J_gene "
        "--attribute=gene_biotype:IG_J_pseudogene "
        "--attribute=gene_biotype:IG_C_gene "
        "--attribute=gene_biotype:IG_C_pseudogene "
        "--attribute=gene_biotype:TR_V_gene "
        "--attribute=gene_biotype:TR_V_pseudogene "
        "--attribute=gene_biotype:TR_D_gene "
        "--attribute=gene_biotype:TR_J_gene "
        "--attribute=gene_biotype:TR_J_pseudogene "
        "--attribute=gene_biotype:TR_C_gene"


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
