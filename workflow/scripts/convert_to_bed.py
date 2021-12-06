# -*- coding: utf-8 -*-
"""Convert to bed file format."""
if __name__ == "__main__":
    from helpers.get_logger import get_logger

    LOG = snakemake.log[0]  # noqa: F821
    PARAMS = snakemake.params  # noqa: F821
    OUTPUT = snakemake.output  # noqa: F821

    logger = get_logger(__name__, LOG)

    with open(OUTPUT["bed"], "w") as file:
        lines = [
            f"chr{pos['chr']} {pos['start']-1} {pos['end']-1} {name}\n"
            for name, pos in PARAMS["genes"].items()
        ]
        file.writelines(lines)
        logger.info(f"Converted to BED file as:\n{lines}")
