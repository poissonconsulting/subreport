context("string")

test_that("string", {
  teardown(subfoldr2::sbf_reset_main())
  subfoldr2::sbf_set_main(tempdir(), "output", rm = TRUE, ask = FALSE)

  x <- "text"
  expect_is(sbf_save_string(x), "character")
  expect_identical(sbr_s("x"), "text")
  expect_error(sbr_s("y"))
})
