# Changelog

<!--next-version-placeholder-->

## v2.0.0 (2021-12-22)
### Feature
* **lift.smk:** Mask gtf_converted as tempfile ([`082ef70`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/082ef70ed59ee3a0b55a19c18bca21fe44f0713e))
* **rules:** Support CellRanger ([`4398450`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/43984501938a5ce961257cf220554d3f59c2082c))

### Fix
* **input_resources.smk:** Add conda environment ([`0383d86`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/0383d860053e1df3a2312fd28774801a172cb782))
* **cellranger.smk:** Correct mkref and count ([`df1ee8a`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/df1ee8ab74285eba946e774f1dba14d94f3547ea))
* **common.smk:** Remove print statement ([`890902b`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/890902bd06ea6e7febb96da8338a3bcaac20c413))
* **cellranger_resources.smk:** Correct allowed biotypes ([`0426d07`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/0426d07215fa43625344af1db335946a8ff8428f))
* **qc_reads.smk:** Increase threads for fastqc ([`d2ce90d`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/d2ce90d38b9f990186377d24149344bf58cea041))
* **lift.smk:** Correct to benchmarks ([`d10adf7`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/d10adf7090ada749c75b960be23c43d033f84ec1))
* **cellranger_resources.smk:** Correct directory location ([`10cfd2a`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/10cfd2a065a38e732cbdb288f15e65441e1eacd8))
* **Snakefile:** Specify correct outputs ([`7e383b2`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/7e383b220d0623741acd1530bca2746f02bdef8a))
* **qc_reads.smk:** Remove star aggregation ([`89a727b`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/89a727be4d181e37a6d38fdda92dbb7c5d1004af))
* **common.smk:** Change aggregation functions ([`482740a`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/482740a7ac3c1fcc1af806225b6776803827849a))
* **schema:** Expand CellRanger parameters ([`efcd9d8`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/efcd9d80dfcdcf00bef9267b99709f437a7ef57e))
* **qc_reads.smk:** Corret FastQ collection ([`a4938a6`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/a4938a6ec3c993cb96e1e3bda9b1d4a573cc4549))
* **input_resources.smk:** Disable container ([`c8612fb`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/c8612fb334f9ea3b736caf2f68892bc42604e3eb))
* **star.smk:** Correct input ([`89592ff`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/89592ffb627065cab52e9028911290202a88c13f))

### Breaking
* Though the reversion does not impact apparent function significantly, the outputs and underlying analysis are changed enough to warrant this BREAKING.  ([`4398450`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/43984501938a5ce961257cf220554d3f59c2082c))

### Documentation
* **counts.rst:** Add missing report file ([`10a45c2`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/10a45c27d61971a6f7f4f3c98f61920ca695016f))
* **rulegraph.svg:** Update rulegraph for new pipeline ([`1cca3e1`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/1cca3e1b31badc6e4ea2a8283161fd0153565f5f))

## v1.1.0 (2021-12-06)
### Feature
* **move_coordinates.bash:** Set `-x` for improved logging ([`85d88d0`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/85d88d0ff3f9d7b8e7e6b3bb502a4ab9139f80d9))

## v1.0.1 (2021-12-06)
### Fix
* **move_coordinates.bash:** Use tmpfiles correctly ([`44df2d0`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/44df2d00d7c2587620011aa54a589b05b62bb052))
* **convert_to_bed.py:** Add newline ([`8a8dc83`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/8a8dc839870dd0f04cc26328b5d9ad7f6c93edd7))
* **lift.yaml:** Set lesser coordinate as start ([`62da900`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/62da900a24c365266b726002399eae2ebccc96b2))

## v1.0.0 (2021-12-06)
### Feature
* **rules:** Add move_coordinate rule ([`f1ec1c4`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/f1ec1c4e0f35f172e8b8d3b31d4b32aef0b29c71))
* **rules:** Add liftover rules ([`4193eaf`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/4193eafb878032a4dfc458fa621143ba96c36eac))
* **convert_to_bed:** Add convert_to_bed rule ([`fba0dd0`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/fba0dd0328c7c548a7a9cfface6a998fc37172ab))
* **config:** Add over.chain urls ([`9828920`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/982892046ea5807293e7e50fd5ed289bb64b3f30))
* **envs:** Add env for lift ([`80518b4`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/80518b48e4307bd3377da4613e9e2adf953ee376))
* **schemas:** Provide validation for lift.yaml ([`b0b5b9c`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/b0b5b9ce8dbe577d6360ec0adbc96637aa52630d))
* **envs_scripts:** Include only necessary environments ([`52f239c`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/52f239c07576c50fa7e9f4644220b2489e9dd2d4))
* **rules:** Convert to star ([`a5d437a`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/a5d437aa765c9816a96e04acd2422db1b60ff91e))

### Fix
* **rule:move_coordinates:** Improve error handling ([`29d4f59`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/29d4f59eca219f04aeb397862fa295462eaafe7e))
* **config.yaml:** Correct urls ([`1e1a4b6`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/1e1a4b642f3c4e2cc1ee7bf77f3ef9d57e76d2f0))
* **resources.smk:** Correct formatting ([`ae12c68`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/ae12c682e41aec395796189e46e858b4c96d2669))
* **qc_reads.smk:** Correct multiqc wrapper ([`f9a75ef`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/f9a75ef4af9bbd85060eb42fd105668579fe1885))
* **common.smk:** Forrect f-string usage ([`a901850`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/a901850c5e99a069cd66531f61b56f8a6266f381))

### Breaking
* I mean, it deletes all the analysis scripts...  ([`52f239c`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/52f239c07576c50fa7e9f4644220b2489e9dd2d4))
* The STAR dependency fundamentally changes the way the pipeline runs.  ([`a5d437a`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/a5d437aa765c9816a96e04acd2422db1b60ff91e))

### Documentation
* **technical:** Updates technica ldocumenation in necessary locations to provide a correct and accurate view of the steps now performed by the pipeline ([`1b21a8f`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/1b21a8f1486728d65817d4d98e850cf18a5ca9dc))
* **reports:** Correct report files ([`78b0d60`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/78b0d600fb48c0fe509759c627ecb2c5f50311c2))
* **documentation.md:** Correct technical notes ([`d13e47b`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/d13e47b8c2548d4d986448e1617132301f860679))
* **README:** Desribe new project aims ([`53611e0`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/53611e034820a088330fd9740e4bd6fc5586486f))

## v0.2.0 (2021-11-22)
### Feature
* **repo:** Initialise project ([`46146d8`](https://github.com/IMS-Bio2Core-Facility/BIC092/commit/46146d8a49c80510e661048d5c28d80734a27673))

## v0.1.1 (2021-11-02)
### Fix
* **config:** Correct sample name ([`d22da64`](https://github.com/IMS-Bio2Core-Facility/single_snake_sequencing/commit/d22da64075de0a7635003d1c56e6f0af93dd34ad))
* **schema:** Disallow non-word characters ([`5648893`](https://github.com/IMS-Bio2Core-Facility/single_snake_sequencing/commit/5648893644ea4e386e050f417d78d54a98e472ff))

### Documentation
* **README:** Correct erroneous link ([`4956f50`](https://github.com/IMS-Bio2Core-Facility/single_snake_sequencing/commit/4956f501d9fb40f21755dd3e3c4b55ac285a2cd6))
* **README/CONTRIBUTING:** Correct erroneous links ([`09c755a`](https://github.com/IMS-Bio2Core-Facility/single_snake_sequencing/commit/09c755ad5021c12e4b66e9f9264fe66cd37745b1))
* **README:** Include install instructions ([`a0679c5`](https://github.com/IMS-Bio2Core-Facility/single_snake_sequencing/commit/a0679c5f8507b9694a5ad0640b620024a1c75399))
* **README:** Correct ci/cd badge ([`db9e476`](https://github.com/IMS-Bio2Core-Facility/single_snake_sequencing/commit/db9e4767e60604aacb5f0a999a2f6da52efe59be))
* **README:** Apply formatting ([`4d6fdbe`](https://github.com/IMS-Bio2Core-Facility/single_snake_sequencing/commit/4d6fdbec61e11585811999521983f17256bf17bc))

## v0.1.0 (2021-10-27)
### Feature
* **repo:** Initiate repository ([`28ea197`](https://github.com/IMS-Bio2Core-Facility/single_snake_sequencing/commit/28ea19797fbde89837e5f0f8892c94f98857148c))

### Documentation
* **README:** Add links ([`d13b9a8`](https://github.com/IMS-Bio2Core-Facility/single_snake_sequencing/commit/d13b9a80a44133eb748b7cde6b1f1af8e224a514))
* **README:** Add badges ([`860e9d6`](https://github.com/IMS-Bio2Core-Facility/single_snake_sequencing/commit/860e9d668900b5125dd74b03adb4359dfd6b411c))
