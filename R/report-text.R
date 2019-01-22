report_text <- function(sub, main) {
  paste0(
    "---
title: ", basename(getwd()),"
date: ", Sys.time(), "
---

```{r, echo = FALSE, warning = FALSE, message = FALSE, include = FALSE, cache = FALSE}
knitr::opts_chunk$set(warning = FALSE, message = FALSE, echo = FALSE, comment = NA, results = 'asis', cache = FALSE)

library(subfoldr2)
sbf_set_main('", normalizePath(main), "')
sbf_set_sub('", sub, "')
```

## Results

### Tables

```{r}
cat(subreport::sbr_tables())
```

### Blocks

```{r}
cat('code blocks')
```

### Plots

```{r}
cat('code blocks')
```
",
    sep = "")}
