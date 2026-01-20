#' Use Project Rmd File
#'
#' Creates a project.Rmd in the root directory.
#' 
#' @export
sbr_use_project_rmd <- function() {
  usethis::use_template(
    template = "project.Rmd",
    package = "subreport"
  )
}

#' Use Project Rmd File
#'
#' Creates a project.Rmd in the root directory.
#' 
#' @export
sbr_use_bibliography <- function() {
  usethis::use_template(
    template = "bibliography.bib",
    package = "subreport"
  )
}
