#' Knit Report
#'
#' Makes a results .Rmd file of the tables, code blocks and plots (and windows)
#' and knits it into a .html file and opens
#' in the default web browser.
#'
#' @param file A string of the file name(s) without an extension.
#' @param report A string of the directory to save the tables, code blocks and plots.
#' @inheritParams subfoldr2::sbf_save_object
#' @inheritParams rmarkdown::render
#' @inheritParams utils::browseURL
#' @param browse A flag specifying whether to open the .html file in a web browser.
#' @return An invisible path to the .Rmd file.
#' @export
sbr_knit_results <- function(file = "results",
                             report = sbr_get_report(),
                             sub = character(0),
                             main = subfoldr2::sbf_get_main(),
                             quiet = FALSE,
                             browse = TRUE,
                             browser = "open") {
  chk_string(file)
  chk_string(report)
  check_values(sub, "")
  check_dim(sub, values = c(0L, 1L))
  chk_string(main)

  dir.create(dirname(file), showWarnings = FALSE, recursive = TRUE)
  input <- paste0(file, ".Rmd")
  writeLines(report_text(sub = sub, main = main), con = input)

  path <- rmarkdown::render(
    input = input,
    output_format = "html_document",
    quiet = quiet
  )
  print(path)
  if (isTRUE(browse)) {
    utils::browseURL(paste0("file://", path), browser = browser)
  }
  invisible(input)
}
