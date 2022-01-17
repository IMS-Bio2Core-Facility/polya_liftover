# polya_liftover - sc/snRNAseq Snakemake Workflow

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Status: Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![CI/CD](https://github.com/IMS-Bio2Core-Facility/polya_liftover/actions/workflows/cicd.yaml/badge.svg)](https://github.com/IMS-Bio2Core-Facility/polya_liftover/actions/workflows/cicd.yaml)
[![Codestyle: Black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![Codestyle: snakefmt](https://img.shields.io/badge/code%20style-snakefmt-000000.svg)](https://github.com/snakemake/snakefmt)

A [Snakemake][sm] workflow for using PolyA_DB and UCSC Liftover with Cellranger.

Some genes are not accurately annotated in the reference genome.
Here,
we use information provide by the [PolyA_DB v3.2][polya] to update the coordinates,
then the [USCS Liftover][liftover] tool to update to a more recent genome.
Next,
we use [Cellranger][cr] to create the reference and count matrix.
Finally,
by taking advantage of the integrated [Conda][conda] and [Singularity][sing] support,
we can run the whole thing in an isolated environment.

## Notes on Installation

Our pipeline is available on Github
(see below!) and on
[WorkflowHub][wh].

### Get the Source Code

Navigate to our [release][releases]
page on github and download the most recent version.

Alternatively,
for the bleeding edge,
please clone the repo like so:

```shell
git clone https://github.com/IMS-Bio2Core-Facility/polya_liftover
```

> :warning: **Heads Up!**
> The bleeding edge may not be stable,
> as it contains all active development.

However you choose to install it,
`cd` into the directory.

### Necessary Software

The only thing you need installed is [conda][conda].
Snakemake recommends using [mambaforge][mambaforge]
as your base conda,
which I would also recommend.
Installation instructions are at the above link.

Once `conda` is installed,
the eastiest way to get up and running is:

```shell
conda env create -f workflow/envs/devel_linux.yaml
```

This installs [Snakemake][sm]
and [Singularity][sing],
plus all the software used in each step.
If you are running Windows or MacOS,
please install using the `workflow/envs/devel.yaml` file.
This installs everything **except** Singularity,
as Singularity is only compatible with Linux.

While the above is easiest,
you don't _technially_ need the software for each step,
as Conda/Snakemake will download each step's software for you as they run.
For a barebones installation,
install [Snakemake][sm] as outlined on their page
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
**Singularity is _not_ required!**
Snakemake will still run each step in its own Conda environment,
it just won't put each Conda environment in a container.

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
Finally,
a sheet providing the output from PolyA_DB must also be supplied.
All are schema validated.

## Notes on Data

This pipeline expects de-multiplexed fastq.gz files,
normally produced by some deriviative of `bcl2fastq` after sequencing.
They can (technically) be placed anywhere,
but we recommend creating a `data` directory in your project for them.

## Notes on the tools

The analysis pipeline was run using Snakemake v6.11.1.
The full version and software lists can be found under the relevant yaml files in `workflow/envs`.
The all reasonable efforts have been made to ensure that the repository adheres to the best practices
outlined [here][sm_bp].

## Notes on the analysis

For a full discussion on the analysis methods,
please see the [technical documentation](workflow/documentation.md).

Briefly,
gene coordinates were updated with [PolyA_DB][polya] version 3,
converted to more recent builds with [Liftover][liftover],
and referenced/counted with [Cellranger][cr].

## Future work

- [ ] Improve species and build handling. See [#2][i2]
- [ ] Directly download and grep the PolyA_DB data. This will aloow users to specify genes only. [#3][i3]

[sm]: https://snakemake.readthedocs.io/en/stable/index.html "Snakemake"
[polya]: https://exon.apps.wistar.org/polya_db/v3/index.php "PolyA_DB"
[liftover]: https://genome.ucsc.edu/cgi-bin/hgLiftOver "Liftover"
[cr]: https://github.com/alexdobin/STAR "Cellranger"
[conda]: https://docs.conda.io/en/latest/ "Conda"
[sing]: https://sylabs.io/singularity/ "Singularity"
[wh]: https://workflowhub.eu/workflows/263 "WorkflowHub"
[mambaforge]: https://github.com/conda-forge/miniforge#mambaforge "Mambaforge"
[sing_install]: https://sylabs.io/guides/3.8/admin-guide/installation.html#installation-on-windows-or-mac "Singularity Install"
[releases]: https://github.com/IMS-Bio2Core-Facility/polya_liftover/releases "Releases"
[sm_bp]: https://snakemake.readthedocs.io/en/stable/snakefiles/deployment.html "Best Practices"
[i2]: https://github.com/IMS-Bio2Core-Facility/polya_liftover/issues/2 "Issue 2"
[i3]: https://github.com/IMS-Bio2Core-Facility/polya_liftover/issues/3 "Issue 3"
