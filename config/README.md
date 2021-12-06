# Configuration

The configuration keys that are expected are given below.
Don't worry about typos, etc.
These are all enforced with Snakemake's brilliant
[schema validation][schema].

## samples.yaml

The top level keys are the lanes from the sequencer.
The second level keys are the samples from that lane.
The third level keys are the paths to the R1 and R2 data.

## lift.yaml

Top level keys are gene names.
Each gene must have 3 values:

1. chr - the chromosome
1. start - the feature start coordinate
1. end - the feature end coordinate

Coordinates should be **exactly as given** by PolyA_DB

## config.yaml

### samplesheet

Path to the samplesheet.
This defaults to `config/samples.yaml`.

### lift

Path to the "lift sheet" - the PolyA-DB outputs.
This defaults to `config/lift.yaml`.

### get_whitelist

- url: str, required. Url to retrieve cell barcode whitelist for STAR.

### get_gtf

- url: str, required. Url to retrieve the reference GTF.

### get_fa

- url: str, required. Url to retrieve the reference primary assembly.

### get_9_to_10

- url: str, required. Url to retrieve the `mm9` to `mm10` over.chain for `LiftOver`

### get_10_to_39

- url: str, required. Url to retrieve the `mm10` to `mm39` over.chain for `LiftOver`

[schema]: https://snakemake.readthedocs.io/en/stable/snakefiles/configuration.html#validation "Schema Validation"
