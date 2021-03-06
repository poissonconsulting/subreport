% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/knit.R
\name{sbr_knit_results}
\alias{sbr_knit_results}
\title{Knit Report}
\usage{
sbr_knit_results(
  file = "results",
  report = sbr_get_report(),
  sub = character(0),
  main = subfoldr2::sbf_get_main(),
  quiet = FALSE,
  browse = TRUE
)
}
\arguments{
\item{file}{A string of the file name(s) without an extension.}

\item{report}{A string of the directory to save the tables, code blocks and plots.}

\item{sub}{A string specifying the path to the sub folder (by default the current sub folder).}

\item{main}{A string specifying the path to the main folder (by default the current main folder)}

\item{quiet}{An option to suppress printing during rendering from knitr,
pandoc command line and others. To only suppress printing of the last
"Output created: " message, you can set \code{rmarkdown.render.message} to
\code{FALSE}}

\item{browse}{A flag specifying whether to open the .html file in a web browser.}
}
\value{
An invisible path to the .Rmd file.
}
\description{
Makes a results .Rmd file of the tables, code blocks and plots (and windows)
and knits it into a .html file and opens
in the default web browser.
}
