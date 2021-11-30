rule index_genome:
    input:
        fa=rules.get_fa.output.fa,
        gtf=rules.get_gtf.output.gtf,
    output:
        directory=directory("resources/star_genome"),
    log:
        "results/logs/index_genome/index_genome.log",
    benchmark:
        "results/benchmarks/index_genome/index_genome.txt"
    conda:
        "../envs/star.yaml"
    threads: 16
    shell:
        "STAR "
        "--runMode genomeGenerate "
        "--runThreadN {threads} "
        "--genomeDir {output.directory} "
        "--genomeFastaFiles {input.fa} "
        "--sjdbGTFfile {input.gtf} "
        "--sjdbOverhang 100 "
        "&> {log}"


rule star:
    input:
        genome=rules.index_genome.output.directory,
        R2="data/{sample}_S1_L00{lane}_R2_001.fastq.gz",
        R1="data/{sample}_S1_L00{lane}_R1_001.fastq.gz",
        wl=rules.get_whitelist.output.wl,
    output:
        logfile="results/star/{sample}_{lane}/Log.final.out",
        star=directory("results/star/{sample}_{lane}/Solo.out/Gene/raw"),
    log:
        "results/logs/star/{sample}_{lane}.log",
    benchmark:
        "results/benchmarks/star/{sample}_{lane}.txt"
    conda:
        "../envs/star.yaml"
    threads: 16
    shell:
        "STAR "
        "--runThreadN {threads} "
        "--runMode alignReads "
        "--genomeDir {input.genome} "
        "--readFilesIn {input.R2} {input.R1} "
        "--readFilesCommand zcat "
        "--outFileNamePrefix results/star/{wildcards.sample}_{wildcards.lane}/ "
        "--outSAMtype BAM Unsorted "
        "--soloType CB_UMI_Simple "
        "--soloCBwhitelist {input.wl} "
        "--soloUMIlen 12 "
        "--soloCellFilter None "
        "--clipAdapterType CellRanger4 "
        "--outFilterScoreMin 30 "
        "--soloCBmatchWLtype 1MM_multi_Nbase_pseudocounts "
        "--soloUMIfiltering MultiGeneUMI_CR "
        "--soloUMIdedup 1MM_CR "
        "--soloFeatures Gene "
        "&> {log}"
