# Uses liftover to convert base coordinates


rule convert_to_bed:
    params:
        genes=lift,
    output:
        bed="results/convert_to_bed/input.bed",
    log:
        "results/logs/convert_to_bed/convert_to_bed.log",
    benchmark:
        "results/benchmarks/convert_to_bed/convert_to_bed.txt"
    conda:
        "../envs/bare_python.yaml"
    script:
        "../scripts/convert_to_bed.py"
