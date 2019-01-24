#' Figures
#'
#' Returns a string of the report plots and windows in markdown format ready for inclusion in a report.
#' If a window and plot have identical names then the plot is dropped.
#'
#' @inheritParams sbr_tables
#' @param width A number of the page width in inches.
#' @return A string of the plots in markdown format.
#' @export
sbr_figures <- function(sub = character(0), report = sbr_get_report(),
                      drop = NULL, sort = NULL, rename = NULL,
                      nheaders = 2L, header1 = 4L, 
                      main = subfoldr2::sbf_get_main(),
                      width = 6) {
  
  check_string(report)
  checkor(check_null(drop), check_vector(drop, ""))
  checkor(check_null(sort), check_vector(sort, "", unique = TRUE))
  checkor(check_null(rename), 
          check_vector(rename, "", unique = TRUE, named = TRUE))
  
  check_scalar(nheaders, c(0L, 5L))
  check_scalar(header1, c(1L, 6L))
  check_scalar(width, c(1, 24))
  
  nheaders <- min(nheaders, (6L - header1))
  
  plots <- sbf_load_plots_recursive(sub = sub, main = main, meta = TRUE)
  windows <- sbf_load_windows_recursive(sub = sub, main = main, meta = TRUE)
  
  plots <- drop_sub(plots, drop = drop)
  windows <- drop_sub(windows, drop = drop)
  
  if(!nrow(windows) && !nrow(plots)) return(character(0))
  
  plots <- drop_duplicate_sub_colnames(plots, windows)
  
  if(nrow(windows)) {
    windows <- transfer_files(windows, ext = "png", report = report, class = "plots")
  } 
  if(nrow(plots)) {
    transfer_files(plots, report = report, ext = "csv")
    plots <- transfer_files(plots, report = report, ext = "png")
  }
  colnames(windows)[1] <- "plots"
  data <- rbind(plots, windows, stringsAsFactors = FALSE)
  
  data <- sort_sub(data, sort = sort)
  data <- rename_sub(data, rename)
  data <- set_headings(data, nheaders, header1)
  
  data$caption <- p0("Figure ", 1:nrow(data), ". ", data$caption)
  data$caption <- add_full_stop(data$caption)
  data$width <- data$width / width * 100
  
  txt <- character(0)
  for (i in seq_len(nrow(data))) {
    heading <- data$heading[i]
    caption <- data$caption[i]
    width <- data$width[i]
    to <- data$to[i]
    
    img <- p0("<img alt = \"", to, "\" src = \"", to,
              "\" title = \"", to, "\" width = \"", width, "%\">")
    
    caption <- p0("<figcaption>", caption, "</figcaption>")
    txt <- c(txt, heading, "<figure>", img, caption, "</figure>")
  }
  txt <- c(txt, "")
  p0(txt, collapse = "\n")
}
