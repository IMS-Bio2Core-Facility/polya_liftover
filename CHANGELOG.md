# Changelog

<!--next-version-placeholder-->

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
