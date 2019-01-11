check_headings <- function(headings, drop, nheaders, header1) {
  check_list(headings)
  check_list(drop)
  check_count(nheaders)
  check_scalar(header1, c(1L, 10L))

  if (!all(vapply(drop, is.character, TRUE)))
    err("drop must be a list of character vectors")

  if (!all(vapply(headings, is.character, TRUE)))
    err("headings must be a list of character vectors")
  
  if (!all(vapply(headings, function(x) !length(x) || !is.null(names), TRUE)))
    err("headings must be a list of named character vectors")

  TRUE
}