test_that("sigfig function works correctly on various numeric types", {
  
  df <- data.frame(
    small_decimal = c(0.123456789, 0.000123456, 1.987654321, 99.9999999),
    large_number = c(1234567.89, 9876543.21, 5555.5555, 1000000.1),
    scientific = c(1.23e-5, 4.56e8, 7.89e-10, 2.34e12),
    integer = c(123L, 456L, 789L, 0L),
    character = c("text", "more", "data", "test"),
    logical = c(TRUE, FALSE, TRUE, FALSE),
    missing = c(NA_real_, NA_real_, NA_real_, NA_real_)
  )
  
  res <- signif_table(df)
  
  expect_equal(res$small_decimal, c(0.123, 0.000123, 1.99, 100))
  expect_equal(res$large_number, c(1230000, 9880000, 5560, 1000000))
  expect_equal(res$scientific, c(1.23e-5, 4.56e8, 7.89e-10, 2.34e12))
  expect_equal(res$integer, c(123, 456, 789, 0))
  expect_equal(res$missing, c(NA_real_, NA_real_, NA_real_, NA_real_))
  
  expect_identical(res$character, df$character)
  expect_identical(res$logical, df$logical)
  
  expect_true(all(sapply(res[c("small_decimal", "large_number", "scientific", "integer")], is.numeric)))
})