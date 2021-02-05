check_headings <- function(headings, drop, nheaders, header1) {
  chk_list(headings)
  chk_list(drop)
  chk_whole_number(nheaders)
  chk_gte(nheaders)
  chk_whole_number(header1)
  chk_range(header1, c(1L, 10L))

  if (!all(vapply(drop, is.character, TRUE)))
    err("drop must be a list of character vectors")

  if (!all(vapply(headings, is.character, TRUE)))
    err("headings must be a list of character vectors")
  
  if (!all(vapply(headings, function(x) !length(x) || !is.null(names), TRUE)))
    err("headings must be a list of named character vectors")

  TRUE
}