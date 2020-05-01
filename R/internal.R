user <- function() {
  unname(Sys.info()["user"])
}

file_path <- function(..., collapse = FALSE) {
  args <- list(...)
  if(!length(args)) return(character(0))
  args <- lapply(args, as.character)
  args <- args[vapply(args, function(x) length(x) > 0L, TRUE)]
  if(collapse)
    args <- lapply(args, p0, collapse = "/")
  do.call("file.path", args)
}

sanitize_path <- function(path, rm_leading = TRUE) {
  path <- sub("//", "/", path)
  path <- sub("(.+)(/$)", "\\1", path)
  if(isTRUE(rm_leading)) path <- sub("(^/)(.*)", "\\2", path)
  path
}

add_full_stop <- function(x) {
  x <- sub("([.])(\\s+$)", ".", x)
  sub("([^.]+$)", "\\1.", x)
}

replace_ext <- function(x, new_ext) {
  sub("[.][^.]+$", p0(".", new_ext), x)
}

capitalize_first_letter_words <- function (x) {
  gsub(pattern = "\\b([a-z])", replacement = "\\U\\1", x, perl = TRUE)
}

rename_sub_sub1 <- function(data) {
  if(!"sub1" %in% colnames(data) && any(data$sub != "")) {
    data$sub1 <- data$sub
    data$sub1[data$sub1 == ""] <- NA_character_
  }
  data$sub <- NULL
  data
}

sub_directories <- function(data) {
  data <- data[grepl("^sub\\d+", names(data))]
  if(!ncol(data)) return(character(0))
  data <- as.matrix(data)
  data[is.na(data)] <- ""
  sub <- apply(data, MARGIN = 1, function(x) do.call("file_path", as.list(x)))
  sub <- sanitize_path(sub)
  sub
}

transfer_files <- function(data, ext, report, class = names(data)[1]) {
  from <- replace_ext(data$file, ext)
  
  data$to <- file_path(report, class, sub_directories(data), data$name)
  data$to <- p0(data$to, ".", ext)
  
  dirs <- unique(dirname(data$to))
  lapply(dirs, dir.create, showWarnings = FALSE, recursive = TRUE)
  mapply(file.copy, from, data$to, MoreArgs = list(overwrite = TRUE))
  data
}

write_files <-function(data, ext, report, fun, class = names(data)[1]) {
  data$to <- file_path(report, class, sub_directories(data), data$name)
  data$to <- p0(data$to, ext)
  dirs <- unique(dirname(data$to))
  lapply(dirs, dir.create, showWarnings = FALSE, recursive = TRUE)
  mapply(fun, data[[1]], data$to)
  data
}

write_csv <- function(x, file) {
  write.csv(x, file, row.names = FALSE)
}

write_txt <- function(x, file) {
  writeLines(x, file)
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
  if(is.null(sort) || !length(sort))
    sort <- "/not_a_possible_sub"
  
  colnames <- sub_colnames(data)
  colnames <- rev(colnames)
  
  names <- sort
  sort <- 1:length(sort)
  names(sort) <- names
  
  data$order <- 1:nrow(data)
  
  for(colname in colnames) {
    is_na <- is.na(data[[colname]])
    
    in_sort <- !is_na & data[[colname]] %in% names(sort)
    
    data_sort <- data[in_sort,]
    data_na <- data[is_na,]
    data <- data[!is_na & !in_sort,]
    
    data_sort$order <- sort[data_sort[[colname]]]
    
    data_sort <- data_sort[order(data_sort$order),]
    data <- data[order(data[[colname]], na.last = FALSE),]
    
    data <- rbind(data_na, data_sort, data)
  }
  data$order <- NULL
  data
}

rename_sub <- function(data, rename) {
  if(is.null(rename)) 
    rename <- c("/not_a_possible_sub" = "please report this bug")
  
  names(rename) <- capitalize_first_letter_words(names(rename))
  
  colnames <- sub_colnames(data, names = FALSE)
  for(colname in colnames) {
    data[[colname]] <- capitalize_first_letter_words(data[[colname]])
    column <- data[[colname]] 
    recognized <- column %in% names(rename) 
    data[[colname]][recognized] <- rename[column[recognized]]
  }
  data
}

new_only <- function(x) {
  n <- length(x)
  if(identical(n, 1L)) return(x)
  new <- rep(NA, n)
  new[1] <- !is.na(x[1])
  for(i in 2:n) {
    new[i] <- !is.na(x[i]) & (is.na(x[i-1]) | x[i] != x[i-1]) 
  }
  x[!new] <- NA_character_
  x
}

last_sub <- function(x) {
  x <- x[!is.na(x)]
  n <- length(x)
  if(!n) return(NA)
  return(x[n])
}

set_headings <- function(data, nheaders, header1) {
  data$heading <- ""
  if(!nheaders) return(data)
  
  colnames <- sub_colnames(data, names = FALSE)
  if(!length(colnames)) return(data)
  
  colnames <- colnames[1:min(nheaders, length(colnames))]
  
  heading <- as.matrix(data[colnames])

  hashes <- matrix("", nrow = nrow(heading), ncol = ncol(heading))
  for(i in 1:ncol(hashes))
    hashes[,i] <- p0(rep("#", i + header1 - 1L), collapse = "")
  
  heading <- apply(heading, MARGIN = 2, new_only)
  
  heading[!is.na(heading)] <- 
    p(hashes[!is.na(heading)], heading[!is.na(heading)])
  
  heading[!is.na(heading)] <- p0("\n", heading[!is.na(heading)], "\n")
  heading[is.na(heading)] <- ""
  
  heading <- as.matrix(heading)
  if(!is.null(row.names(heading))) heading <- t(heading)
  heading <- apply(heading, MARGIN = 1, p0, collapse = "")
  
  data$heading <- heading
  data
}

drop_duplicate_sub_colnames <- function(data1, data2) {
  if(!nrow(data1) || !nrow(data2)) return(data1)
  
  sub1 <- data1[sub_colnames(data1)]
  sub2 <- data2[sub_colnames(data2)]
  
  sub <- data.table::rbindlist(list(sub2, sub1), fill = TRUE)
  wch <- which(duplicated(sub))
  if(!length(wch)) return(data1)
  wch <- wch - nrow(sub2)
  data1[-wch,,drop = FALSE]  
}
