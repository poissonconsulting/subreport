rm_all <- function(ask) {
  check_flag(ask)
  
  report <- sbr_get_report()

  if (!dir.exists(report)) return(NULL)
  
  msg <- paste0("Delete directory '", report, "'?")

  if (!ask || yesno(msg)) unlink(report, recursive = TRUE)
  NULL
}
