# Retrieve resources for liftOver


rule get_9_to_10:
    params:
        url=config["get_9_to_10"]["url"],
    output:
        over_9_to_10="resources/mm9Tomm10.over.chain",
    log:
        "results/logs/get_9_to_10/get_9_to_10.log",
    benchmark:
        "results/benchmarks/get_9_to_10/get_9_to_10.txt"
    shell:
        "wget "
        "--no-verbose -O- "
        "{params.url} | "
        "gunzip > {output.over_9_to_10} "
        "2> {log}"


rule get_10_to_39:
    params:
        url=config["get_10_to_39"]["url"],
    output:
        over_10_to_39="resources/mm10Tomm39.over.chain",
    log:
        "results/logs/get_10_to_39/get_9_to_10.log",
    benchmark:
        "results/benchmarks/get_10_to_39/get_9_to_10.txt"
    shell:
        "wget "
        "--no-verbose -O- "
        "{params.url} | "
        "gunzip > {output.over_10_to_39} "
        "2> {log}"
