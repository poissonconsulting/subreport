#' Knit Report
#' 
#' Knit's tables, code blocks and plots (and windows) into a html file and 
#' if browse = TRUE opens in the default web browser.
#'
#' @param file A string of the output file name without an extension.
#' @param report A string of the directory to save the output file.
#' @inheritParams subfoldr2::sbf_save_object
#' @inheritParams rmarkdown::render
#' @param browse A flag specifying whether to open the html file.
#' @return An invisible path to the .html file.
#' @export
#'
#' @examples
sbr_knit_report <- function(file = "report", 
                            report = sbr_get_report(),
                            sub = subfoldr2::sbf_get_sub(),
                            main = subfoldr2::sbf_get_main(),
                            quiet = FALSE, browse = TRUE) {
  check_string(file)
  check_string(report)
  check_vector(sub, "", length = c(0L, 1L))
  check_string(main)
  check_flag(browse)
  
  report <- sanitize_path(report, rm_leading = FALSE)
  sub <- sanitize_path(sub)
  main <- sanitize_path(main, rm_leading = FALSE)
  
  input <- file_path(report, file)
  input <- replace_ext(input, "Rmd")

  dir.create(dirname(input), showWarnings = FALSE, recursive = TRUE)

  writeLines(report_text(sub = sub, main = main), con = input)

  path <- rmarkdown::render(input = input, output_file = file)
  if(isTRUE(browse))
    utils::browseURL(paste0('file://', path))
  invisible(path)
}
