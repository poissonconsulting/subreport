signif_table <- function(x, sigfig = 3L) {
  numeric_cols <- sapply(x, is.numeric)
  x[numeric_cols] <- lapply(x[numeric_cols], function(x) signif(x, sigfig))
  x
}
