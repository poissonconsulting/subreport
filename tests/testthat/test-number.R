context("number")

test_that("number", {
  teardown(subfoldr2::sbf_reset_main())
  subfoldr2::sbf_set_main(tempdir(), "output", rm = TRUE, ask = FALSE)

  x <- 2
  expect_is(sbf_save_number(x), "character")
  expect_identical(sbr_n("x"), 2)
  expect_error(sbr_n("y"))
})
