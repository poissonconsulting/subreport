report_text <- function(sub, main) {
  paste0(
    "---
title: '", basename(getwd()), "'
date: ", Sys.time(), "
---

```{r, echo = FALSE, warning = FALSE, message = FALSE, include = FALSE, cache = FALSE}
knitr::opts_chunk$set(warning = FALSE, message = FALSE, echo = FALSE, comment = NA, results = 'asis', cache = FALSE)

main <- '", normalizePath(main), "'
sub <- '", sub, "'
```

## Results

### Strings

```{r}
cat(subreport::sbr_strings(sub = sub, main = main, tag = '.+'))
```

### Blocks

```{r}
cat(subreport::sbr_blocks(sub = sub, main = main))
```

### Tables

```{r}
cat(subreport::sbr_tables(sub = sub, main = main))
```

### Figures

```{r}
cat(subreport::sbr_figures(sub = sub, main = main))
```
",
    sep = "")}
