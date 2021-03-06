% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/blocks.R
\name{sbr_blocks}
\alias{sbr_blocks}
\title{Blocks}
\usage{
sbr_blocks(
  x_name = ".*",
  sub = character(0),
  report = sbr_get_report(),
  tag = ".*",
  drop = NULL,
  sort = NULL,
  rename = NULL,
  nheaders = 2L,
  header1 = 4L,
  main = subfoldr2::sbf_get_main()
)
}
\arguments{
\item{x_name}{A string of the regular expression to match file names.}

\item{sub}{A string of the path to the root sub folder.}

\item{report}{A string of the path to the report folder.}

\item{tag}{A string of the regular expression that the tag must match to be included.}

\item{drop}{A character vector specifying the sub folders and file names to exclude from the report or NULL.}

\item{sort}{A character vector specifying the initial sort order for sub folders and file names or NULL.
Missing items appear afterwards in alphabetical order.}

\item{rename}{A unique named character vector specifying new heading names for sub folders or NULL.
By default sub folder names have the first letter of each word capitalized.}

\item{nheaders}{A count of the number of sub folder levels to assign headers to.}

\item{header1}{A count of the heading level for the first sub folder level.}

\item{main}{A string of the path to the main folder.}
}
\value{
A string of the code blocks in markdown format.
}
\description{
Returns a string of the report code blocks in markdown format ready for inclusion in a report.
}
