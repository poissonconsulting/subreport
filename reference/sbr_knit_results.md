# Knit Report

Makes a results .Rmd file of the tables, code blocks and plots (and
windows) and knits it into a .html file and opens in the default web
browser.

## Usage

``` r
sbr_knit_results(
  file = "results",
  report = sbr_get_report(),
  sub = character(0),
  main = subfoldr2::sbf_get_main(),
  quiet = FALSE,
  browse = TRUE,
  browser = "open"
)
```

## Arguments

- file:

  A string of the file name(s) without an extension.

- report:

  A string of the directory to save the tables, code blocks and plots.

- sub:

  A string specifying the path to the sub folder (by default the current
  sub folder).

- main:

  A string specifying the path to the main folder (by default the
  current main folder)

- quiet:

  An option to suppress printing during rendering from knitr, pandoc
  command line and others. To only suppress printing of the last "Output
  created: " message, you can set `rmarkdown.render.message` to `FALSE`

- browse:

  A flag specifying whether to open the .html file in a web browser.

- browser:

  a non-empty character string giving the name of the program to be used
  as the HTML browser. It should be in the PATH, or a full path
  specified. Alternatively, an R function to be called to invoke the
  browser.

  Under Windows `NULL` is also allowed (and is the default), and implies
  that the file association mechanism will be used.

## Value

An invisible path to the .Rmd file.
