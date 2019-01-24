#' Database Meta Tables
#'
#' Returns a string of the database metatables in markdown format ready for inclusion in a report.
#'
#' @inheritParams sbr_tables
#' @return A string of the metatables in markdown format.
#' @export
sbr_databases <- function(sub = character(0), 
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
  
  data <- sbf_load_dbs_metatable_recursive(sub = sub, main = main, meta = TRUE)
  data <- drop_sub(data, drop = drop)
 
  if(!nrow(data)) return(character(0))
  
  data <- transfer_files(data, ext = "sqlite", overwrite = overwrite, class = "databases")
  data <- write_files(data, ext = ".csv", fun = write_csv, overwrite = overwrite, class = "databases")

  data <- sort_sub(data, sort = sort)
  data <- rename_sub(data, rename)
  data <- set_headings(data, nheaders, header1)
  
  data$caption <- p0("Database ", 1:nrow(data), ". ", data$caption)
  data$caption <- add_full_stop(data$caption)
  
  txt <- character(0)
  for (i in seq_len(nrow(data))) {
    heading <- data$heading[i]
    caption <- data$caption[i]
    
    table <- data$metatables[[i]]
    table <- knitr::kable(table, format = "markdown", row.names = FALSE)
    
    txt <- c(txt, heading, caption, "", table)
  }
  txt <- c(txt, "")
  p0(txt, collapse = "\n")
}
