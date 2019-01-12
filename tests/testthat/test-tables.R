context("tables")

test_that("tables", {
  teardown(subfoldr2::sbf_reset_main())
  teardown(sbr_reset_report())

  subfoldr2::sbf_set_main(tempdir(), "output", rm = TRUE, ask = FALSE)
  sbr_set_report(tempdir(), "report", rm = TRUE, ask = FALSE)
  
  x <- data.frame(obs = "JD", count = 1L)
  subfoldr2::sbf_save_table(x, caption = "Observations")
  
  txt <- sbr_tables()
  expect_identical(txt, "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n")
  expect_identical(list.files(sbr_get_report(), recursive = TRUE), "tables/x.csv")
  
  subfoldr2::sbf_save_table(x, x_name = "y", report = FALSE)
  expect_identical(sbr_tables(), txt)
  expect_identical(list.files(sbr_get_report(), recursive = TRUE), 
                   "tables/x.csv", "tables/y.csv")
  
  expect_identical(sbr_tables(drop = "x"), character(0))
  
  z <- data.frame(Site = 1:2, Name = c("parlour", "study"))
  subfoldr2::sbf_save_table(z, caption = "Sites")
  expect_identical(sbr_tables(), 
                   "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n")
  
  expect_identical(sbr_tables(sort = "z"),
                   "\nTable 1. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\nTable 2. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n")
  
  subfoldr2::sbf_set_sub("RB", "max like")
  subfoldr2::sbf_save_table(x, caption = "Extra Obs")
  subfoldr2::sbf_save_table(z, caption = "More Sites")

  expect_identical(sbr_tables(nheaders = 0L), "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\nTable 3. Extra Obs.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 4. More Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n")
  
  expect_identical(sbr_tables(sort = "z", nheaders = 0L), "\nTable 1. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\nTable 2. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 3. More Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\nTable 4. Extra Obs.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n")
  
  expect_identical(sbr_tables(), "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\n### RB\n\n#### Max Like\n\nTable 3. Extra Obs.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 4. More Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n")
  
    expect_identical(sbr_tables(header1 = 1L), "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\n# RB\n\n## Max Like\n\nTable 3. Extra Obs.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 4. More Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n")
    
  expect_identical(sbr_tables(rename = c("max like" = "max Like", "RB" = "Rainbow trout")), "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 2. Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n\n### Rainbow trout\n\n#### max Like\n\nTable 3. Extra Obs.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n\nTable 4. More Sites.\n\n| Site|Name    |\n|----:|:-------|\n|    1|parlour |\n|    2|study   |\n")
})
