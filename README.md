
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-CMD-check](https://github.com/poissonconsulting/subreport/workflows/R-CMD-check/badge.svg)](https://github.com/poissonconsulting/subreport/actions)
[![Codecov test
coverage](https://codecov.io/gh/poissonconsulting/subreport/branch/master/graph/badge.svg)](https://codecov.io/gh/poissonconsulting/subreport?branch=master)
[![License:
MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

# subreport

`subreport` is an R package to generate `.html` results reports and
custom markdown for tables, figures (plots, windows and png files) and
(code) blocks saved using the
[subfoldr2](https://github.com/poissonconsulting/subreport) package.

The `sbr_knit_results()` function allows the user to view a .html report
with all the tables, figures and blocks while the `sbr_tables()`,
`sbr_figures()` and `sbr_blocks()` functions produce markdown code
complete with headings, numbered labels and captions of their respective
objects.

The `sbr_n()` and `sbr_s()` functions allow numbers and strings to be
inserted into .Rmd reports.

## Usage

``` r
library(subfoldr2)
library(subreport)

sbf_set_main(tempdir(), "output")
sbr_set_report(tempdir(), "report")

y <- data.frame(t = 2, comment = "blah blah")
sbf_save_table(y, sub = "Factoids", caption = "A really interesting summary")

cat(sbr_tables())
#> 
#> #### Factoids
#> 
#> Table 1. A really interesting summary.
#> 
#> |  t|comment   |
#> |--:|:---------|
#> |  2|blah blah |
```

## Installation

To install the latest development version from GitHub
[repository](https://github.com/poissonconsulting/subreport)

``` r
# install.packages("remotes")
remotes::install_github("poissonconsulting/subreport")
```

## Contribution

Please report any
[issues](https://github.com/poissonconsulting/subreport/issues).

[Pull requests](https://github.com/poissonconsulting/subreport/pulls)
are always welcome.

## Code of Conduct

Please note that the subreport project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
