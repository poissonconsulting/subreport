#' Use Project Rmd File
#'
#' Creates a project.Rmd file in the root directory.
#' 
#' @export
sbr_use_project_rmd <- function() {
  usethis::use_template(
    template = "project.Rmd",
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
