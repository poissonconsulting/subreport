#' Get String
#'
#' @inheritParams subfoldr2::sbf_load_string
#' @return A string.
#' @export
sbr_string <- function(x_name, sub = character(0)) {
  sbf_load_string(x_name, sub = sub)
}

#' @rdname sbr_string
#' @export
sbr_s <- function(x_name, sub = character(0)) {
  sbr_string(x_name, sub = sub)
}

