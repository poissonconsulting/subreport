# Set Report

The directory is created when needed if it doesn't already exist.

## Usage

``` r
sbr_set_report(..., rm = FALSE, ask = getOption("sbf.ask", TRUE))
```

## Arguments

- ...:

  One or more character vectors which are combined together.

- rm:

  A flag specifying whether to remove the folder and all its contents if
  it already exists.

- ask:

  A flag specifying whether to ask before removing the existing folder.

## Value

An invisible string of the path to the main folder.
