#' Figures
#'
#' Returns a string of the report plots and windows in markdown format ready for inclusion in a report.
#' If a window and plot have identical names then the plot is dropped.
#'
#' @inheritParams sbr_tables
#' @param width A number of the page width in inches.
#' @return A string of the plots in markdown format.
#' @export
sbr_figures <- function(x_name = ".*", sub = character(0), report = sbr_get_report(),
                        tag = ".*",
                        drop = NULL, sort = NULL, rename = NULL,
                        nheaders = 2L, header1 = 4L, 
                        main = subfoldr2::sbf_get_main(),
                        width = 6) {
  
  chk_string(x_name)
  chk_string(report)
  chk_string(tag)
  if(!is.null(drop)) {
    chk_vector(drop)
    check_values(drop, "")
  }
  if(!is.null(sort)) {
    chk_vector(sort)
    check_values(sort, "")
    chk_unique(sort)
  }
  if(!is.null(rename)) {
    chk_vector(rename) 
    check_values(rename, "")
    chk_unique(rename)
    chk_named(rename)
  }

  chk_scalar(nheaders)
  chk_range(nheaders, c(0L, 5L))
  chk_scalar(header1)
  chk_range(header1, c(1L, 6L))
  chk_scalar(width)
  chk_range(width, c(1, 24))
  
  nheaders <- min(nheaders, (7L - header1))
  
  plots <- sbf_load_plots_recursive(sub = sub, main = main, meta = TRUE, 
                                    tag = tag)
  windows <- sbf_load_windows_recursive(sub = sub, main = main, meta = TRUE, 
                                        tag = tag)
  
  plots <- rename_sub_sub1(plots)
  windows <- rename_sub_sub1(windows)

  plots <- drop_sub(plots, drop = drop)
  windows <- drop_sub(windows, drop = drop)
  
  plots <- plots[grepl(x_name, plots$name),]
  windows <- windows[grepl(x_name, windows$name),]
  
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

  if(!nrow(windows)) {
    data <- plots
  } else if(!nrow(plots)) {
    data <- windows
  } else
    data <- data.table::rbindlist(list(plots, windows), fill = TRUE)

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
