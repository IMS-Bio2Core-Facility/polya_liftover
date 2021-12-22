from snakemake.utils import validate
import re
from pathlib import Path
from yaml import safe_load

# Validate structures
with open(config["samples"], "r") as file:
    metadata = safe_load(file)
    validate(metadata, schema="../schema/samples.schema.yaml")

with open(config["lift"], "r") as file:
    lift = safe_load(file)
    validate(lift, schema="../schema/lift.schema.yaml")

validate(config, schema="../schema/config.schema.yaml")

# Some useful variables
LANES = list(metadata.keys())
SAMPLES = set()
for _, v in metadata.items():
    SAMPLES = SAMPLES.union(v.keys())

CR_VERSION = re.search("cellranger-\d.\d.\d", config["get_cellranger"]["url"]).group(0)


# wildcard restraints - as reads can only be R1 or R2
wildcard_constraints:
    read="R[12]",


# Input functions
def get_fastqs(wildcards):
    """Return all FASTQS specified in sample metadata."""
    return (metadata[wildcards.lane][wildcards.sample][wildcards.read],)


def get_bcl_results():
    """Retrieve the bcl results files."""
    bcls = list(Path("data").glob("*.bcl2fastq.zip"))
    return dict(
        bcl_zip=bcls,
    )


def agg_fastqc():
    """Aggregate input from FASTQC for MultiQC.

    A simple snakemake expand is not used to avoid the cross product,
    as not all samples will be in all lanes.

    A checkpoint could be used. However, wildcard constraints and the sample sheet
    guarantee we can know this a priori.
    """
    fastq_out = []
    for lane, samples in metadata.items():
        for sample in samples.keys():
            fastq_out = fastq_out + [
                f"results/fastqc/{lane}_{sample}_{read}_fastqc.zip"
                for read in ["R1", "R2"]
            ]
    return dict(
        fastqc=fastq_out,
    )


def agg_cr_html():
    """Aggregate CellRanger html output.

    A simple snakemake expand is not used to avoid the cross product,
    as not all samples will be in all lanes.

    A checkpoint could be used. However, wildcard constraints and the sample sheet
    guarantee we can know this a priori.
    """
    cr_out = []
    for lane, samples in metadata.items():
        for sample in samples.keys():
            cr_out = cr_out + [f"results/counts/{sample}_{lane}/outs/web_summary.html"]
    return dict(
        cr_html=cr_out,
    )


def convert_introns():
    """Specify whether introns should be counted

    For ease of use, the user only specifies True or False
    This function handles the conversion.
    """
    if config["counts"]["introns"]:
        return "--include-introns"
    else:
        return ""
