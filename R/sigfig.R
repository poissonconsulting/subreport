signif_table <- function(x, sigfig = 3L) {
  x[sapply(x, is.numeric)] <- lapply(x[sapply(x, is.numeric)], function(x) signif(x, sigfig))
  x
}
