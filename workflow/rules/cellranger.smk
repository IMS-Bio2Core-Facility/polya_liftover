rule mkgtf:
    input:
        gtf=rules.move_coordinates.output.gtf,
        bin=rules.get_cellranger.output.bin,
    output:
        gtf="resources/genome_filtered.gtf",
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


rule mkref:
    input:
        gtf=rules.mkgtf.output.gtf,
        fa=rules.get_fa.output.fa,
        bin=rules.get_cellranger.output.bin,
    output:
        ref=directory("resources/ref_genome"),
    log:
        "results/logs/mkref/mkref.log",
    benchmark:
        "results/benchmarks/mkref/mkref.txt"
    shell:
        "{input.bin} "
        "mkref "
        "--genome={output.ref} "
        "--genes={input.gtf} "
        "--fasta={input.fa} "


rule count:
    input:
        R1="data/{sample}_S1_L00{lane}_R1_001.fastq.gz",
        R2="data/{sample}_S1_L00{lane}_R2_001.fastq.gz",
        bin=rules.get_cellranger.output.bin,
        genome=rules.mkref.output.ref,
    output:
        results=directory("results/counts/{sample}_{lane}/outs/raw_feature_bc_matrix"),
        mtx="results/counts/{sample}_{lane}/outs/raw_feature_bc_matrix/matrix.mtx.gz",
        html=report(
            "results/counts/{sample}_{lane}/outs/web_summary.html",
            caption="../reports/counts.rst",
            category="2. Cellranger Counts",
            subcategory="{sample}_{lane}",
        ),
    params:
        introns=convert_introns(),
        n_cells=config["counts"]["n_cells"],
        mem=config["counts"]["mem"],
    log:
        "results/logs/counts/{sample}_{lane}.log",
    benchmark:
        "results/benchmarks/counts/{sample}_{lane}.txt"
    threads: 16
    shell:
        "{input.bin} "
        "count "
        "--nosecondary "
        "{params.introns} "
        "--id {wildcards.sample}_{wildcards.lane} "
        "--transcriptome {input.genome}  "
        "--fastqs data "
        "--sample {wildcards.sample} "
        "--lanes {wildcards.lane} "
        "--expect-cells {params.n_cells} "
        "--localcores {threads} "
        "--localmem {params.mem} "
        "&> {log} && "
        "mv {wildcards.sample}_{wildcards.lane} results/counts/{wildcards.sample}_{wildcards.lane} "
