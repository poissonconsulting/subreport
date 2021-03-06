% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/report.R
\name{sbr_reset_report}
\alias{sbr_reset_report}
\title{Reset Report}
\usage{
sbr_reset_report(rm = FALSE, ask = getOption("sbr.ask", TRUE))
}
\arguments{
\item{rm}{A flag specifying whether to remove the folder and all its contents if it already exists.}

\item{ask}{A flag specifying whether to ask before removing the existing folder.}
}
\value{
An invisible copy of the string \code{"report"}.
}
\description{
Reset Report
}
