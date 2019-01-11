context("tables")

test_that("tables", {
  teardown(subfoldr2::sbf_reset_main())
  teardown(sbr_reset_report())

  subfoldr2::sbf_set_main(tempdir(), "output", rm = TRUE, ask = FALSE)
  sbr_set_report(tempdir(), "report", rm = TRUE, ask = FALSE)
  
  x <- data.frame(x = 1:3, y = c("oe", NA, "oeeeeee"))
  expect_is(subfoldr2::sbf_save_table(x, caption = "Nice one"), "character")
  
  sbr_tables()
  
  expect_identical(list.files(sbr_get_report(), recursive = TRUE),
                   "tables/x.csv")
  
  expect_identical(subfoldr2::sbf_set_sub("sub"), "sub")
  x <- data.frame()
  expect_is(subfoldr2::sbf_save_table(x, caption = "Nice two"), "character")
  
  expect_identical(list.files(sbr_get_report(), recursive = TRUE),
                   "tables/x.csv", "tables/sub/x.csv")
  
})
