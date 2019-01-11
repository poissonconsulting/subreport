file_path <- function(...) {
  args <- list(...)
  if(!length(args)) return(character(0))
  args <- lapply(args, as.character)
  args <- args[vapply(args, function(x) length(x) > 0L, TRUE)]
  do.call("file.path", args)
}

sanitize_path <- function(path, rm_leading = TRUE) {
  path <- sub("//", "/", path)
  path <- sub("(.+)(/$)", "\\1", path)
  if(isTRUE(rm_leading)) path <- sub("(^/)(.+)", "\\2", path)
  path
}

add_full_stop <- function(x) {
  sub("([^.]$)", "\\1.", x)
}

replace_ext <- function(x, new_ext) {
  sub("[.][^.]+$", p0(".", new_ext), x)
}

sub_directories <- function(data) {
  data <- data[grepl("^sub\\d+", names(data))]
  if(!ncol(data)) return(character(0))
  data <- as.matrix(data)
  data[is.na(data)] <- ""
  sub <- apply(data, MARGIN = 1, file_path)
  sub <- sanitize_path(sub)
  sub
}

transfer_files <- function(data, ext, overwrite, class = names(data)[1]) {
  from <- replace_ext(data$file, ext)
  
  data$to <- file_path(sbr_get_report(), class, sub_directories(data), data$name)
  data$to <- p0(data$to, ".", ext)
  
  dirs <- unique(dirname(data$to))
  lapply(dirs, dir.create, showWarnings = FALSE, recursive = TRUE)
  mapply(file.copy, from, data$to, MoreArgs = list(overwrite = overwrite))
  data
}

sub_colnames <- function(data, names = TRUE) {
  colnames <- colnames(data)
  colnames <- colnames[grepl("^sub\\d+", colnames)]
  if(isTRUE(names)) colnames <- c(colnames, "name")
  colnames
}

drop_sub <- function(data, drop) {
  data <- data[data$report,]
  if(!nrow(data) || is.null(drop) || !length(drop)) return(data)

  colnames <- sub_colnames(data)
  for(colname in colnames)
    data <- data[!data[[colname]] %in% drop,]
  
  data
}

sort_sub <- function(data, sort) {
  if(is.null(sort) || !length(sort)) return(data)

  colnames <- sub_colnames(data)
  colnames <- rev(colnames) # so names first
#  for(colname in colnames)
#    data <- data[!data[[colname]] %in% drop,]
  
  data
}

rename_sub <- function(data, rename) {
  if(is.null(rename)) return(data)

  colnames <- sub_colnames(data, names = FALSE)
  for(colname in colnames)
#    data <- data[!data[[colname]] %in% drop,]
#
    
  data
}

set_headings <- function(data, nheaders, header1) {
  ## where need to 
  colnames <- sub_colnames(data, names = FALSE)
  data
}
