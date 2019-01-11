#' Tables
#'
#' Returns a string of tables in markdown format ready for inclusion in a report.
#'
#' The names in the character vectors in headings indicate the new headings for each subfolder.
#' By default missing subfolders receive their current name with the first letter of each word capitalized.
#' Subfolders with the name "" do not receive a heading.
#' The order of the subfolders indicates the order in which they should appear.
#' By default missing subfolders appear in alphabetical order.
#' The first named character vector is applied to the highest level of subfolders starting at sub and so on.
#' The number of character vectors indicates the number of levels that should receive headings.
#' By default the highest level of subfolders are considered to be third order headings.
#'
#' The elements in the character vectors in drop indicate the subfolders to exclude from the report.
#' Again the number of the character vector indicates the level to which it applies.
#'
#' @param sub A string of the path to the sub folder.
#' @param headings A list of named character vectors.
#' @param drop A list of character vectors specify the sub folders to drop.
#' @param nheaders A count of the number of headings to assign headers to.
#' @param header1 A count of the heading level for the first header.
#' @param locale A string of the locale.
#' @param overwrite A flag specifying whether to overwrite existing files in the report folder.
#' @return A string of the report templates in markdown format ready for inclusion in a report.
#' @export
sbr_tables <- function(sub = character(0), headings = list(character(0)), 
                      drop = list(character(0)),
                      nheaders = 0L, header1 = 3L,
                      locale = "en", overwrite = TRUE) {
  check_headings(headings = headings, drop = drop, 
                 nheaders = nheaders, header1 = header1, locale = locale)
  check_flag(overwrite)
  
  data <- sbf_load_tables_recursive(sub = sub, meta = TRUE)
  data <- filter_files(data, drop = drop)
  
  if(!nrow(data)) return(character(0))

  data$to <- transfer_files(data, ext = "csv", overwrite = overwrite)
#  data <- sort_headings(data, headings = headings, nheaders = nheaders, header1 = header1)
  
  txt <- character(0)
  for (i in seq_len(nrow(data))) {
#    heading <- data$heading[i]
    
    caption <- p0("Table ", i, ". ", data$caption[i])
    caption <- add_full_stop(caption)
    
    table <- data$tables[[i]]
    table <- knitr::kable(table, format = "markdown", row.names = FALSE)
    
    #txt <- c(txt, heading, "")
    txt <- c(txt, caption, "")
    txt <- c(txt, table, "")
  }
  p0(txt, collapse = "\n")
}
