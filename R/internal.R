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
  
  to <- file_path(sbr_get_report(), class, sub_directories(data), data$name)
  to <- p0(to, ".", ext)

  dirs <- unique(dirname(to))
  lapply(dirs, dir.create, showWarnings = FALSE, recursive = TRUE)
  mapply(file.copy, from, to, MoreArgs = list(overwrite = overwrite))
  invisible(to)
}

filter_files <- function(data, drop) {
  data <- data[data$report,]
  if(!nrow(data) || !length(drop)) return(data)
  names(drop) <- p0("sub", 1:length(drop))
  drop <- drop[names(drop) %in% names(data)]
  for(name in names(drop))
    data <- data[!data[[name]] %in% drop[[name]],]
  data
}
