# Uses liftover to convert base coordinates


rule liftover_9to10:
    input:
        bed=rules.convert_to_bed.output.bed,
        chain=rules.get_9_to_10.output.over_9_to_10,
    output:
        bed="results/liftover/9to10.bed",
        unmapped="results/liftover/9to10_unmapped.bed",
    log:
        "results/logs/liftover/9to10.log",
    benchmark:
        "results/benchmarks/liftover/9to10.txt"
    conda:
        "../envs/lift.yaml"
    shell:
        "liftOver "
        "{input.bed} "
        "{input.chain} "
        "{output.bed} "
        "{output.unmapped} "
        "&> {log} "


rule liftover_10to39:
    input:
        bed=rules.liftover_9to10.output.bed,
        chain=rules.get_10_to_39.output.over_10_to_39,
    output:
        bed="results/liftover/10to39.bed",
        unmapped="results/liftover/10to39_unmapped.bed",
    log:
        "results/logs/liftover/10to39.log",
    benchmark:
        "results/benchmarks/liftover/10to39.txt"
    conda:
        "../envs/lift.yaml"
    shell:
        "liftOver "
        "{input.bed} "
        "{input.chain} "
        "{output.bed} "
        "{output.unmapped} "
        "&> {log} "


rule move_coordinates:
    input:
        bed=rules.liftover_10to39.output.bed,
        gtf=rules.get_gtf.output.gtf,
    output:
        gtf="resources/genome_converted.gtf",
    log:
        "results/logs/move_coordinates/move_coordinates.log",
    benchmark:
        "results/benchmark/move_coordinates/move_coordinates.txt"
    shell:
        "workflow/scripts/move_coordinates.bash "
        "-b {input.bed} "
        "-g {input.gtf} "
        "-o {output.gtf} "
        "&> {log}"
