#' Strings
#'
#' Returns a string of the report strings in markdown list(s) format ready for inclusion in a report.
#'
#' @inheritParams sbr_tables
#' @param numbered A flag specifying whether the list(s) items should be numbered.
#' @return A string of the code blocks in markdown format.
#' @export
sbr_strings <- function(x_name = ".*", sub = character(0), report = sbr_get_report(),
                       tag = ".*", drop = NULL, sort = NULL, rename = NULL,
                       nheaders = 2L, header1 = 4L, numbered = FALSE,
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
  chk_flag(numbered)

  nheaders <- min(nheaders, (7L - header1))
  
  data <- sbf_load_strings_recursive(sub = sub, main = main, meta = TRUE,
                                    tag = tag)
  data <- rename_sub_sub1(data)

  data <- drop_sub(data, drop = drop)
  
  data <- data[grepl(x_name, data$name),]
  
  if(!nrow(data)) return(character(0))
  
  data <- write_files(data, ext = ".txt", report = report, fun = write_txt)

  data <- sort_sub(data, sort = sort)
  data <- rename_sub(data, rename)
  data <- set_headings(data, nheaders, header1)
  
  number <- 1
  txt <- character(0)
  for (i in seq_len(nrow(data))) {
    
    heading <- data$heading[i]
    if(heading == "" && i > 1) {
      heading <- NULL
      number <- number + 1
    } else 
      number <- 1
    
    string <- data$strings[[i]]
    if(numbered) {
      string <- p0(number, ". ", string)
    } else
      string <- p0("- ", string)
    
    txt <- c(txt, heading, string)
  }
  txt <- c(txt, "")
  p0(txt, collapse = "\n")
}
