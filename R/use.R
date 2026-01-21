#' Use Report File
#'
#' Creates a report.Rmd file in the root directory.
#' 
#' @export
sbr_use_report <- function() {
  usethis::use_template(
    template = "report.Rmd",
    package = "subreport"
  )
}

#' Use Bibliography
#'
#' Creates a bibliography.bib file in the root directory.
#' 
#' @export
sbr_use_bibliography <- function() {
  usethis::use_template(
    template = "bibliography.bib",
    package = "subreport"
  )
}

#' Use Knit Report
#'
#' Creates a knit-report.R file in the root directory.
#' 
#' @export
sbr_use_knit_report <- function() {
  usethis::use_template(
    template = "knit-report.R",
    package = "subreport"
  )
}

#' Use Knit Report All
#'
#' Creates knit-report.R, bibliography.bib and and knit-report.R files
#'  in the root directory.
#' 
#' @export
sbr_use_knit_report_all <- function() {
  sbr_use_report()
  sbr_use_bibliography()
  sbr_use_knit_report()
}
