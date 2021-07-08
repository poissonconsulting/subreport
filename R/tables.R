#' Tables
#'
#' Returns a string of the report tables in markdown format ready for inclusion in a report.
#'
#' @param x_name A string of the regular expression to match file names.
#' @param sub A string of the path to the root sub folder.
#' @param report A string of the path to the report folder.
#' @param tag A string of the regular expression that the tag must match to be included.
#' @param drop A character vector specifying the sub folders and file names to exclude from the report or NULL.
#' @param sort A character vector specifying the initial sort order for sub folders and file names or NULL.
#' Missing items appear afterwards in alphabetical order.
#' @param rename A unique named character vector specifying new heading names for sub folders or NULL.
#' By default sub folder names have the first letter of each word capitalized.
#' @param nheaders A count of the number of sub folder levels to assign headers to.
#' @param header1 A count of the heading level for the first sub folder level.
#' @param main A string of the path to the main folder.
#' @return A string of the tables in markdown format.
#' @export
sbr_tables <- function(x_name = ".*", sub = character(0), report = sbr_get_report(),
                       tag = ".*", drop = NULL, sort = NULL, rename = NULL,
                       nheaders = 2L, header1 = 4L,
                       main = subfoldr2::sbf_get_main()) {
  
  chk_string(x_name)
  chk_string(report)
  chk_string(tag)
  chkor(chk_null(drop), c(chk_vector(drop), check_values(drop, "")))
  chkor(chk_null(sort), c(chk_vector(sort), check_values(sort, ""), chk_unique(sort)))
  chkor(chk_null(rename), c(chk_vector(rename), check_values(rename, ""), 
                            chk_unique(rename), chk_named(rename)))

  chk_scalar(nheaders)
  chk_range(nheaders, c(0L, 5L))
  chk_scalar(header1)
  chk_range(header1, c(1L, 6L))

  nheaders <- min(nheaders, (7L - header1))
  
  data <- sbf_load_tables_recursive(sub = sub, main = main, meta = TRUE,
                                    tag = tag)
  data <- rename_sub_sub1(data)

  data <- drop_sub(data, drop = drop)
  
  data <- data[grepl(x_name, data$name),]
 
  if(!nrow(data)) return(character(0))
  
  data <- write_files(data, report = report, ext = ".csv", fun = write_csv)
  
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
