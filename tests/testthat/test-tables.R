context("tables")

test_that("tables", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()
  
  x <- data.frame(obs = "JD", count = 1L)
  subfoldr2::sbf_save_table(x, caption = "Observations")
  
  txt <- sbr_tables()
  expect_identical(txt, "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n")
  expect_identical(list.files(sbr_get_report(), recursive = TRUE), "tables/x.csv")
  
  subfoldr2::sbf_save_table(x, x_name = "y", report = FALSE)
  expect_identical(sbr_tables(), txt)
  expect_identical(list.files(sbr_get_report(), recursive = TRUE), 
                   "tables/x.csv", "tables/y.csv")
  
  x_csv <- utils::read.csv(file.path(sbr_get_report(), "tables/x.csv"))
  expect_identical(x_csv, x)
  
  expect_identical(sbr_tables(drop = "x"), character(0))
  
  z <- data.frame(Site = 1:2, Name = c("parlour", "study"))
  subfoldr2::sbf_save_table(z, caption = "Sites")
  expect_identical(sbr_tables(), 
                   "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n")
  
  expect_identical(sbr_tables("x"),
                   "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n")
  
  expect_identical(sbr_tables("(x)|(z)"), 
                   "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n")

  expect_identical(sbr_tables(sort = "z"),
                   "\nTable 1. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\nTable 2. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n")
  
  subfoldr2::sbf_set_sub("RB", "max like")
  subfoldr2::sbf_save_table(x, caption = "Extra Obs")
  subfoldr2::sbf_save_table(z, caption = "More Sites")

  expect_identical(sbr_tables(nheaders = 0L), "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\nTable 3. Extra Obs.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 4. More Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n")
  
  expect_identical(sbr_tables(sort = "z", nheaders = 0L), "\nTable 1. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\nTable 2. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 3. More Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\nTable 4. Extra Obs.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n")
  
  expect_identical(sbr_tables(), "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\n#### RB\n\n##### Max Like\n\nTable 3. Extra Obs.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 4. More Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n")
  
    expect_identical(sbr_tables(header1 = 1L), "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\n# RB\n\n## Max Like\n\nTable 3. Extra Obs.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 4. More Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n")
    
  expect_identical(sbr_tables(rename = c("max like" = "max Like", "RB" = "Rainbow trout")), "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\n#### Rainbow trout\n\n##### max Like\n\nTable 3. Extra Obs.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 4. More Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n")
  
  subfoldr2::sbf_set_sub("RB", "max like", "number6")
  subfoldr2::sbf_save_table(x, caption = "Tiny")
  
    expect_identical(sbr_tables(rename = c("max like" = "max Like", "RB" = "Rainbow trout")), "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\n#### Rainbow trout\n\n##### max Like\n\nTable 3. Extra Obs.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 4. More Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\nTable 5. Tiny.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n")
    
  expect_identical(sbr_tables(rename = c("max like" = "max Like", "RB" = "Rainbow trout"), nheaders = 3L), "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\n#### Rainbow trout\n\n##### max Like\n\nTable 3. Extra Obs.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 4. More Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\n###### Number6\n\nTable 5. Tiny.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n")
})

test_that("tables sub", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()
  
  x <- data.frame(obs = "JD", count = 1L)
  subfoldr2::sbf_save_table(x, sub = "A sub", caption = "Observations")
  
  txt <- sbr_tables()
  expect_identical(txt, "\n#### A Sub\n\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n")
  expect_identical(list.files(sbr_get_report(), recursive = TRUE), "tables/A sub/x.csv")
})

test_that("tables missing caption", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()
  
  x <- data.frame(obs = "JD", count = 1L)
  subfoldr2::sbf_save_table(x)
  
  txt <- sbr_tables()
  expect_identical(txt, "\nTable 1.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n")
  expect_identical(list.files(sbr_get_report(), recursive = TRUE), "tables/x.csv")
})

test_that("tables sort sub and name", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()
  
  a <- data.frame(obs = "JD", count = "A")
  subfoldr2::sbf_save_table(a)
  
  subfoldr2::sbf_save_table(a, sub = "b")
  
  txt <- sbr_tables()
  expect_identical(txt, "\nTable 1.\n\n|obs |count |\n|:---|:-----|\n|JD  |A     |\n\n#### B\n\nTable 2.\n\n|obs |count |\n|:---|:-----|\n|JD  |A     |\n")
  expect_identical(list.files(sbr_get_report(), recursive = TRUE), 
                   c("tables/a.csv", "tables/b/a.csv"))
  
  txt <- sbr_tables(sort = c("b", "a"))
  expect_identical(txt, "\nTable 1.\n\n|obs |count |\n|:---|:-----|\n|JD  |A     |\n\n#### B\n\nTable 2.\n\n|obs |count |\n|:---|:-----|\n|JD  |A     |\n")
})

test_that("tables with []", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()
  
  x <- data.frame(term = c("par[1]", "par[2]"), count = 1:2)
  subfoldr2::sbf_save_table(x)
  
  txt <- sbr_tables()
  expect_identical(txt, "\nTable 1.\n\n|term   | count|\n|:------|-----:|\n|par[1] |     1|\n|par[2] |     2|\n")
  expect_identical(list.files(sbr_get_report(), recursive = TRUE), "tables/x.csv")
})
