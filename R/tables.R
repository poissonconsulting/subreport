#' Tables
#'
#' Returns a string of the report tables in markdown format ready for inclusion in a report.
#'
#' @param sub A string of the path to the root sub folder.
#' @param drop A character vector specifying the sub folders and file names to exclude from the report or NULL.
#' @param sort A character vector specifying the initial sort order for sub folders and file names or NULL.
#' Missing items appear afterwards in alphabetical order.
#' @param rename A unique named character vector specifying new heading names for sub folders or NULL.
#' By default sub folder names have the first letter of each word capitalized.
#' @param nheaders A count of the number of sub folder levels to assign headers to.
#' @param header1 A count of the heading level for the first sub folder level.
#' @param overwrite A flag specifying whether to overwrite existing files in the report folder.
#' @param main A string of the path to the main folder.
#' @return A string of the tables in markdown format.
#' @export
sbr_tables <- function(sub = character(0), 
                       drop = NULL, sort = NULL, rename = NULL,
                       nheaders = 2L, header1 = 4L, overwrite = TRUE,
                       main = subfoldr2::sbf_get_main()) {
  
  checkor(check_null(drop), check_vector(drop, ""))
  checkor(check_null(sort), check_vector(sort, "", unique = TRUE))
  checkor(check_null(rename), 
          check_vector(rename, "", unique = TRUE, named = TRUE))
  
  check_scalar(nheaders, c(0L, 5L))
  check_scalar(header1, c(1L, 6L))
  check_flag(overwrite)

  nheaders <- min(nheaders, (6L - header1))
  
  data <- sbf_load_tables_recursive(sub = sub, main = main, meta = TRUE)
  data <- drop_sub(data, drop = drop)
 
  if(!nrow(data)) return(character(0))
  
  data <- write_csv_files(data, overwrite = overwrite)
  
  data <- sort_sub(data, sort = sort)
  data <- rename_sub(data, rename)
  data <- set_headings(data, nheaders, header1)
  
  data$caption <- p0("Table ", 1:nrow(data), ". ", data$caption)
  data$caption <- add_full_stop(data$caption)

  txt <- character(0)
  for (i in seq_len(nrow(data))) {
    heading <- data$heading[i]
    caption <- data$caption[i]
    
    table <- data$tables[[i]]
    table <- knitr::kable(table, format = "markdown", row.names = FALSE)
    
    txt <- c(txt, heading, caption, "", table)
  }
  txt <- c(txt, "")
  p0(txt, collapse = "\n")
}
