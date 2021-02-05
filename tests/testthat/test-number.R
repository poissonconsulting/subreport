context("number")

test_that("number", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, rm = TRUE, ask = FALSE)
  sbf_reset_sub()

  x <- 2
  expect_is(sbf_save_number(x), "character")
  expect_identical(sbr_n("x"), 2)
  expect_error(sbr_n("y"))
})
