# subreport

`subreport` is an R package to generate `.html` results reports and
custom markdown for tables, figures (plots, windows and png files) and
(code) blocks saved using the
[subfoldr2](https://github.com/poissonconsulting/subreport) package.

The
[`sbr_knit_results()`](https://poissonconsulting.github.io/subreport/reference/sbr_knit_results.md)
function allows the user to view a .html report with all the tables,
figures and blocks while the
[`sbr_tables()`](https://poissonconsulting.github.io/subreport/reference/sbr_tables.md),
[`sbr_figures()`](https://poissonconsulting.github.io/subreport/reference/sbr_figures.md)
and
[`sbr_blocks()`](https://poissonconsulting.github.io/subreport/reference/sbr_blocks.md)
functions produce markdown code complete with headings, numbered labels
and captions of their respective objects.

The
[`sbr_n()`](https://poissonconsulting.github.io/subreport/reference/sbr_number.md)
and
[`sbr_s()`](https://poissonconsulting.github.io/subreport/reference/sbr_string.md)
functions allow numbers and strings to be inserted into .Rmd reports.

## Usage

``` R
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

``` R
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
