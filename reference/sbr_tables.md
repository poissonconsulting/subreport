# Tables

Returns a string of the report tables in markdown format ready for
inclusion in a report.

## Usage

``` r
sbr_tables(
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
  sigfig = 4L,
  sigfig_override = NULL,
  md = TRUE,
  pre_num = getOption("sbr.pre_num_tab", 0L)
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

  A named character vector specifying new heading names for sub folders
  or NULL. By default sub folder names have the first letter of each
  word capitalized. Sub folders with the same new heading name are
  combined under one heading.

- nheaders:

  A count of the number of sub folder levels to assign headers to.

- header1:

  A count of the heading level for the first sub folder level.

- main:

  A string of the path to the main folder.

- sigfig:

  A positive integer of the significant figures to use when formatting
  numbers. This is applied to all tables unless `md = TRUE` in which
  case it is only applied to tables without a `.md` file.

- sigfig_override:

  A named vector of table names and the number of significant figures to
  use. This will override the default set in `sigfig` and the `.md` file
  for matching tables. Names are matched against the table name
  (`x_name`) only so `c(coef = 2)` applies to all tables named `coef`
  regardless of sub folder.

- md:

  A flag specifying whether to use the `.md` file of each table saved by
  [`subfoldr2::sbf_save_table()`](https://poissonconsulting.github.io/subfoldr2/reference/sbf_save_table.html),
  which is rounded following the rounding policy, with the decimal
  points aligned using figure and punctuation spaces. Tables in
  `sigfig_override` and tables without a `.md` file are formatted using
  significant figures.

- pre_num:

  A count specifying the number of pre-existing items.

## Value

A string of the tables in markdown format.

## Examples

``` r
main <- withr::local_tempdir()
report <- withr::local_tempdir()

coef <- data.frame(
  term = c("intercept", "slope"),
  estimate = c(0.531247, 12.43219),
  lower = c(0.21153, 9.81272),
  upper = c(0.85131, 15.0517)
)
subfoldr2::sbf_save_table(
  coef,
  sub = "fish",
  main = main,
  caption = "Model coefficients"
)
sites <- data.frame(site = c("Upper", "Lower"), length = c(1234.567, 89.1234))
subfoldr2::sbf_save_table(
  sites,
  sub = "habitat",
  main = main,
  caption = "Site lengths"
)

# use the rounded .md file of each table
# (figure and punctuation space entities align the decimal points)
# pre_num = 0L restarts the table numbering, which otherwise continues
# from the previous call
cat(sbr_tables(main = main, report = report, pre_num = 0L))
#> 
#> #### Fish
#> 
#> Table 1. Model coefficients.
#> 
#> | term      | estimate | lower | upper |
#> | :-------- | -------: | ----: | ----: |
#> | intercept | 0.53 | 0.21 | 0.85 |
#> | slope | 12.4&#8199; | 9.8&#8199; | 15&#8200;&#8199;&#8199; |
#> 
#> #### Habitat
#> 
#> Table 2. Site lengths.
#> 
#> | site  |   length |
#> | :---- | -------: |
#> | Upper | 1,235&#8200;&#8199;&#8199; |
#> | Lower | 89.12 |

# format all tables to 3 significant figures instead
cat(sbr_tables(
  main = main,
  report = report,
  md = FALSE,
  sigfig = 3,
  pre_num = 0L
))
#> 
#> #### Fish
#> 
#> Table 1. Model coefficients.
#> 
#> |term      | estimate| lower| upper|
#> |:---------|--------:|-----:|-----:|
#> |intercept |    0.531| 0.212| 0.851|
#> |slope     |     12.4|  9.81|  15.1|
#> 
#> #### Habitat
#> 
#> Table 2. Site lengths.
#> 
#> |site  | length|
#> |:-----|------:|
#> |Upper |   1230|
#> |Lower |   89.1|

# format the coef table to 2 significant figures
cat(sbr_tables(
  main = main,
  report = report,
  md = FALSE,
  sigfig = 3,
  sigfig_override = c(coef = 2),
  pre_num = 0L
))
#> 
#> #### Fish
#> 
#> Table 1. Model coefficients.
#> 
#> |term      | estimate| lower| upper|
#> |:---------|--------:|-----:|-----:|
#> |intercept |     0.53|  0.21|  0.85|
#> |slope     |       12|   9.8|    15|
#> 
#> #### Habitat
#> 
#> Table 2. Site lengths.
#> 
#> |site  | length|
#> |:-----|------:|
#> |Upper |   1230|
#> |Lower |   89.1|

# only include the fish tables and rename the heading
cat(sbr_tables(
  main = main,
  report = report,
  keep = "fish",
  rename = c(fish = "Fish Model"),
  md = FALSE,
  pre_num = 0L
))
#> 
#> #### Fish Model
#> 
#> Table 1. Model coefficients.
#> 
#> |term      | estimate|  lower|  upper|
#> |:---------|--------:|------:|------:|
#> |intercept |   0.5312| 0.2115| 0.8513|
#> |slope     |    12.43|  9.813|  15.05|
```
