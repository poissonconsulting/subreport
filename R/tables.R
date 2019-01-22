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
                       nheaders = 3L, header1 = 3L, overwrite = TRUE,
                       main = subfoldr2::sbf_get_main()) {
  
  checkor(check_null(drop), check_vector(drop, ""))
  checkor(check_null(sort), check_vector(sort, "", unique = TRUE))
  checkor(check_null(rename), 
          check_vector(rename, "", unique = TRUE, named = TRUE))
  
  check_scalar(nheaders, c(0L, 3L))
  check_scalar(header1, c(1L, 5L))
  check_flag(overwrite)
  check_string(main)
  
  main2 <- sbf_get_main()

  data <- sbf_load_tables_recursive(sub = sub, meta = TRUE)
  data <- drop_sub(data, drop = drop)
  
  if(!nrow(data)) return(character(0))
  
  data <- transfer_files(data, ext = "csv", overwrite = overwrite)
  
  data <- sort_sub(data, sort = sort)
  data <- rename_sub(data, rename)
  data <- set_headings(data, nheaders, header1)
  
  txt <- character(0)
  for (i in seq_len(nrow(data))) {
      heading <- data$heading[i]
    
    caption <- p0("Table ", i, ". ", data$caption[i])
    caption <- add_full_stop(caption)
    
    table <- data$tables[[i]]
    table <- knitr::kable(table, format = "markdown", row.names = FALSE)
    
    txt <- c(txt, heading, caption, "", table)
  }
  txt <- c(txt, "")
  p0(txt, collapse = "\n")
}
