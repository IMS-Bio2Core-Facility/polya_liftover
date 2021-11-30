# single_snake_sequencing - sc/snRNAseq Snakemake Workflow

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Status: Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![CI/CD](https://github.com/IMS-Bio2Core-Facility/single_snake_sequencing/actions/workflows/cicd.yaml/badge.svg)](https://github.com/IMS-Bio2Core-Facility/single_snake_sequencing/actions/workflows/cicd.yaml)
[![Codestyle: Black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![Codestyle: snakefmt](https://img.shields.io/badge/code%20style-snakefmt-000000.svg)](https://github.com/snakemake/snakefmt)

A [Snakemake][sm] workflow for using USCS Liftover with STAR.

Some genes are not accurately annotated in the reference genome.
Here,
we use information provide by the [PolyA_DB v3.2][polya] to update the coordinates,
then the [USCS Liftover][liftover] tool to update to a more recent genome.
Next,
we use [STAR][star] to create the reference and count matrix.
Finally,
by taking advantage of the integrated [Conda][conda] and [Singularity][sing] support,
we can run the whole thing in an isolated environment.

## Notes on Installation

### Necessary Software

This pipeline needs [conda][conda]
and [snakemake][sm]
installed,
and runs best if you also have [singularity][sing]
installed,
though it's not required.

Snakemake recommends using [mambaforge][mambaforge]
as your base conda,
which I would also recommend.
Installation instructions are at the above link.
If you prefer a vanilla conda installation,
you can always try `mamba` following the instructions at the above snakemake link.
Once you have conda installed,
install snakemake as outlined on their page
(again, see the above link)
and activate your snakemake environment.

If you are running on a Linux system,
then singularity can be installed from conda like so:

```shell
conda install -n snakemake -c conda-forge singularity
```

It's a bit more challenging for other operating systems.
Your best bet is to follow their instructions
[here][sing_install].
But don't worry!
**Singularity is _not_ regquired!**
Snakemake will still run each step in its own Conda environment,
it just won't put each Conda environment in a container.

### Get the Source Code

Navigate to our [release][releases]
page on github and download the most recent version.
The following will do the trick:

```shell
curl -s https://api.github.com/repos/IMS-Bio2Core-Facility/BIC092/releases/latest |
grep tarball_url |
cut -d " " -f 4 |
tr -d '",' |
xargs -n1 curl -sL |
tar xzf -
```

After querying the github api to get the most recent release information,
we grep for the desired URL,
split the line and extract the field,
trim superfluous characters,
use `xargs` to pipe this to `curl` while allowing for re-directs,
and un-tar the files.
Easy!

Alternatively,
for the bleeding edge,
please clone the repo like so:

```shell
git clone https://github.com/IMS-Bio2Core-Facility/BIC092
```

> :warning: **Heads Up!**
> The bleeding edge may not be stable,
> as it contains all active development.

However you choose to install it,
`cd` into the directory.

### Running

Once you've installed the above software,
and fetched the code,
running the pipeline is as simple as:

```shell
snakemake --use-conda --use-singularity --cores 6
```

If you aren't using `singularity`,
then leave off the apropriate flag, as so:

```shell
snakemake --use-conda --cores 6
```

And `snakemake` will automatically leave it off.

## Notes on Configuration

> :warning:  **Be sure to change the configuration to suit your project!**

For a full discussion of configuration,
please see the [configuration README](config/README.md).

Briefly,
the general configuration file must be located at `config/config.yaml`.
A samplesheet containing information pertaining to the data must be supplied as well.
Both are schema validated.

## Notes on Data

This pipeline expects de-multiplexed fastq.gz files,
normally produced by some deriviative of `bcl2fastq` after sequencing.
They can (technically) be placed anywhere,
but we recommend creating a `data` directory in your project for them.

## Notes on the tools

The analysis pipeline was run using Snakemake v6.6.1.
The full version and software lists can be found under the relevant yaml files in `workflow/envs`.
The all reasonable efforts have been made to ensure that the repository adheres to the best practices
outlined [here](https://snakemake.readthedocs.io/en/stable/snakefiles/deployment.html).

## Notes on the analysis

For a full discussion on the analysis methods,
please see the [technical documentation](workflow/documentation.md).

Briefly,
gene coordinates were update with [PolyA_DB][polya],
converted to more recent builds with [Liftover][liftover],
built into a reference with [STAR][star],
and counted with [STARSolo][starsolo].

[sm]: https://snakemake.readthedocs.io/en/stable/index.html "Snakemake"
[polya]: https://exon.apps.wistar.org/polya_db/v3/index.php "PolyA_DB"
[liftover]: https://genome.ucsc.edu/cgi-bin/hgLiftOver "Liftover"
[star]: https://github.com/alexdobin/STAR "STAR"
[conda]: https://docs.conda.io/en/latest/ "Conda"
[sing]: https://sylabs.io/singularity/ "Singularity"
[mambaforge]: https://github.com/conda-forge/miniforge#mambaforge "Mambaforge"
[sing_install]: https://sylabs.io/guides/3.8/admin-guide/installation.html#installation-on-windows-or-mac "Singularity Install"
[releases]: https://github.com/IMS-Bio2Core-Facility/BIC092/releases "Releases"
[starsolo]: https://github.com/alexdobin/STAR/blob/master/docs/STARsolo.md "STARSolo"
