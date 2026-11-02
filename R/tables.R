#' Tables
#'
#' Returns a string of the report tables in markdown format ready for inclusion in a report.
#'
#' @param x_name A string of the regular expression to match file names.
#' @param sub A string of the path to the root sub folder.
#' @param report A string of the path to the report folder.
#' @param tag A string of the regular expression that the tag must match to be included.
#' @param drop A character vector specifying the sub folders and file names to exclude from the report or NULL.
#' @param keep A character vector specifying the highest level sub folders to keep that are not in drop. If NULL all highest level subfolders that are not in drop are kept.
#' @param sort A character vector specifying the initial sort order for sub folders and file names or NULL.
#' Missing items appear afterwards in alphabetical order.
#' @param rename A named character vector specifying new heading names for sub folders or NULL.
#' By default sub folder names have the first letter of each word capitalized.
#' Sub folders with the same new heading name are combined under one heading.
#' @param nheaders A count of the number of sub folder levels to assign headers to.
#' @param header1 A count of the heading level for the first sub folder level.
#' @param main A string of the path to the main folder.
#' @param sigfig A positive integer of the significant figures to use when formatting numbers. This is applied to all tables unless `md = TRUE` in which case it is only applied to tables without a `.md` file.
#' @param sigfig_override A named vector of table names and the number of significant figures to use. This will override the default set in `sigfig` and the `.md` file for matching tables.
#' @param md A flag specifying whether to use the `.md` file of each table saved by [subfoldr2::sbf_save_table()], which is rounded following the rounding policy, with the decimal points aligned using figure and punctuation spaces.
#' Tables in `sigfig_override` and tables without a `.md` file are formatted using significant figures.
#' @param pre_num A count specifying the number of pre-existing items.
#' @return A string of the tables in markdown format.
#' @export
sbr_tables <- function(
  x_name = ".*",
  sub = character(0),
  report = sbr_get_report(),
  tag = ".*",
  drop = NULL,
  keep = NULL,
  sort = NULL,
  rename = NULL,
  nheaders = 2L,
  header1 = 4L,
  main = subfoldr2::sbf_get_main(),
  sigfig = 4L,
  sigfig_override = NULL,
  md = TRUE,
  pre_num = getOption("sbr.pre_num_tab", 0L)
) {
  chk_string(x_name)
  chk_string(report)
  chk_string(tag)
  if (!is.null(drop)) {
    chk_vector(drop)
    check_values(drop, "")
  }
  if (!is.null(keep)) {
    chk_vector(keep)
    check_values(keep, "")
  }
  if (!is.null(sort)) {
    chk_vector(sort)
    check_values(sort, "")
    chk_unique(sort)
  }
  if (!is.null(rename)) {
    chk_vector(rename)
    check_values(rename, "")
    chk_named(rename)
  }

  chk_scalar(nheaders)
  chk_range(nheaders, c(0L, 5L))
  chk_scalar(header1)
  chk_range(header1, c(1L, 6L))

  chk_whole_number(sigfig)
  chk_gte(sigfig)
  chk_null_or(sigfig_override, vld = vld_named)
  chk_null_or(sigfig_override, vld = vld_whole_numeric)
  chk_null_or(sigfig_override, vld = vld_gte)
  chk_null_or(names(sigfig_override), vld = vld_unique)
  chk_flag(md)
  chk_count(pre_num)

  nheaders <- min(nheaders, (7L - header1))

  data <- sbf_load_tables_recursive(
    sub = sub,
    main = main,
    meta = TRUE,
    tag = tag,
    drop = drop
  )
  data$md_sub <- sanitize_path(file.path(p0(sub, collapse = "/"), data$sub))
  data <- rename_sub_sub1(data)

  data <- keep_sub(data, keep = keep)

  data <- data[grepl(x_name, data$name), ]

  if (!nrow(data)) {
    return(character(0))
  }

  transfer_files(data, report = report, ext = "yaml")
  transfer_files(data, report = report, ext = "md")
  data <- write_files(data, report = report, ext = ".csv", fun = write_csv)

  data <- sort_sub(data, sort = sort)
  data <- rename_sub(data, rename)
  data <- set_headings(data, nheaders, header1)

  data$caption <- p0("Table ", 1:nrow(data) + pre_num, ". ", data$caption)
  data$caption <- add_full_stop(data$caption)

  txt <- character(0)
  no_md <- character(0)
  for (i in seq_len(nrow(data))) {
    heading <- data$heading[i]
    caption <- data$caption[i]
    nm <- data$name[i]

    if (md && !nm %in% names(sigfig_override)) {
      table <- sbf_load_table_md(
        nm,
        sub = data$md_sub[i],
        main = main,
        entities = TRUE,
        exists = NA
      )
      if (!is.null(table)) {
        txt <- c(txt, heading, caption, "", table)
        next
      }
      no_md <- c(no_md, file_path(data$md_sub[i], nm))
    }

    table <- data$tables[[i]]
    # done before formatting to character in signif_table
    numeric_cols <- sapply(table, is.numeric)
    alignment <- ifelse(numeric_cols, "r", "l")

    if (!is.null(sigfig_override) && nm %in% names(sigfig_override)) {
      table <- signif_table(table, sigfig = sigfig_override[[nm]])
    } else {
      table <- signif_table(table, sigfig = sigfig)
    }

    table <- knitr::kable(
      table,
      format = "markdown",
      row.names = FALSE,
      align = alignment
    )

    txt <- c(txt, heading, caption, "", table)
  }
  if (length(no_md)) {
    message(
      "The following tables have no `.md` file and were formatted to ",
      sigfig,
      " significant figures: ",
      cc(sanitize_path(no_md), " and ")
    )
  }
  options(sbr.pre_num_tab = nrow(data) + pre_num)
  txt <- c(txt, "")
  p0(txt, collapse = "\n")
}
