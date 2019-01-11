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
#' @return A string of the report templates in markdown format ready for inclusion in a report.
#' @export
sbr_tables <- function(sub = character(0), headings = list(character(0)), 
                      drop = list(character(0)),
                      nheaders = 0L, header1 = 3L,
                      locale = "en") {
  check_headings(headings = headings, drop = drop, 
                 nheaders = nheaders, header1 = header1, locale = locale)
  data <- sbf_load_tables_recursive(sub = sub, meta = TRUE)
  data <- data[data$report,]
  
  if(!nrow(data)) return(character(0))
  
  data$to <- transfer_files(data, ext = "csv")
  
#  data <- 
  
  # files <- md_files(headings = headings, drop = drop, main = main,
  #                   sub = sub, nheaders = nheaders,
  #                   header1 = header1,
  #                   locale = locale, class = "tables")

  # txt <- NULL
  # 
  # for (i in seq_along(files)) {
  # 
  #   file <- files[i]
  # 
  #   caption <- readRDS(file)$caption
  #   caption %<>% add_full_stop()
  #   caption %<>% str_c("Table ", incr_table_number(), ". ", .)
  # 
  #   file %<>% str_replace("(_)([^/]+)(.RDS)", "\\2.rds")
  #   table <- readRDS(file = file)
  # 
  #   txt %<>% c(names(files)[i]) %>% c("")
  # 
  #   txt %<>% c(caption) %>% c("")
  #   txt %<>% c(knitr::kable(table, format = "markdown", row.names = FALSE))
  #   txt %<>% c("")
  # }
  # txt %<>% str_c(collapse = "\n")
  data
}
