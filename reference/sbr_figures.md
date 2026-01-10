# Figures

Returns a string of the report plots and windows in markdown format
ready for inclusion in a report. If a window and plot have identical
names then the plot is dropped.

## Usage

``` r
sbr_figures(
  x_name = ".*",
  sub = character(0),
  report = sbr_get_report(),
  tag = ".*",
  drop = NULL,
  keep = NULL,
  sort = NULL,
  rename = NULL,
  nheaders = 2L,
  header1 = 4L,
  main = subfoldr2::sbf_get_main(),
  width = 6,
  pre_num = getOption("sbr.pre_num_fig", 0L)
)
```

## Arguments

- x_name:

  A string of the regular expression to match file names.

- sub:

  A string of the path to the root sub folder.

- report:

  A string of the path to the report folder.

- tag:

  A string of the regular expression that the tag must match to be
  included.

- drop:

  A character vector specifying the sub folders and file names to
  exclude from the report or NULL.

- keep:

  A character vector specifying the highest level sub folders to keep
  that are not in drop. If NULL all highest level subfolders that are
  not in drop are kept.

- sort:

  A character vector specifying the initial sort order for sub folders
  and file names or NULL. Missing items appear afterwards in
  alphabetical order.

- rename:

  A unique named character vector specifying new heading names for sub
  folders or NULL. By default sub folder names have the first letter of
  each word capitalized.

- nheaders:

  A count of the number of sub folder levels to assign headers to.

- header1:

  A count of the heading level for the first sub folder level.

- main:

  A string of the path to the main folder.

- width:

  A number of the page width in inches.

- pre_num:

  A count specifying the number of pre-existing items.

## Value

A string of the plots in markdown format.
