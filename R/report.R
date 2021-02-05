#' Get Report
#'
#' @return A string specifying the report directory.
#' @export
#' @examples
#' sbr_get_report()
sbr_get_report <- function() {
  path <- getOption("sbr.report", "report")
  sanitize_path(path, rm_leading = FALSE)
}

#' Set Report
#'
#' The directory is created when needed 
#'  if it doesn't already exist.
#' 
#' @inheritParams subfoldr2::sbf_set_main
#' @return An invisible string of the path to the main folder.
#' @export
sbr_set_report <- function(..., rm = FALSE, ask = getOption("sbf.ask", TRUE)) {
  chk_flag(rm)
  chk_flag(ask)
  path <- file_path(...)
  path <- sanitize_path(path, rm_leading = FALSE)
  options(sbr.report = path)
  if(rm) rm_all(ask = ask)
  invisible(path)
}

#' Reset Report
#'
#' @inheritParams subfoldr2::sbf_set_main
#' @return An invisible copy of the string \code{"report"}.
#' @export
sbr_reset_report <- function(rm = FALSE, ask = getOption("sbr.ask", TRUE)) {
  invisible(sbr_set_report("report", rm = rm, ask = ask))
}
