context("string")

test_that("string", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, rm = TRUE, ask = FALSE)
  sbf_reset_sub()

  x <- "text"
  expect_is(sbf_save_string(x), "character")
  expect_identical(sbr_s("x"), "text")
  expect_error(sbr_s("y"))
})
