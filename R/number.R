#' Get Number
#' 
#' @inheritParams subfoldr2::sbf_load_number 
#' @return A number.
#' @export
sbr_number <- function(x_name, sub = character(0)) {
  sbf_load_number(x_name, sub = sub)
}

#' @rdname sbr_number
#' @export
sbr_n <- function(x_name, sub = character(0)) {
  sbr_number(x_name, sub = sub)
}
