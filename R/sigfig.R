signif_table <- function(x, sigfig = 3L) {
  numeric_cols <- sapply(x, is.numeric)
  x[numeric_cols] <- lapply(x[numeric_cols], function(col) {
    formatted <- signif(col, sigfig)
    format(formatted, trim = TRUE, drop0trailing = TRUE)
  })
  x
}
