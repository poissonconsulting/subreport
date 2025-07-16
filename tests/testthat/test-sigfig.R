test_that("sigfig function works correctly on various numeric types", {
  df <- data.frame(
    small_decimal = c(0.123456789, 0.000123456, 1.987654321, 99.9999999),
    large_number = c(1234567.89, 9876543.21, 5555.5555, 1000000.1),
    scientific = c(1.23e-5, 4.56e8, 7.89e-10, 2.34e12),
    integer = c(123L, 456L, 789L, 0L),
    character = c("text", "more", "data", "test"),
    logical = c(TRUE, FALSE, TRUE, FALSE),
    missing = c(NA, NA, NA, NA)
  )

  res <- signif_table(df)

  expect_equal(res$small_decimal, c("1.23e-01", "1.23e-04", "1.99", "1.00e+02"))
  expect_equal(res$large_number, c("1230000", "9880000", "5560", "1000000"))
  expect_equal(res$scientific, c("1.23e-05", "4.56e+08", "7.89e-10", "2.34e+12"))
  expect_equal(res$integer, c("123", "456", "789", "0"))
  expect_equal(res$missing, c(NA, NA, NA, NA))

  expect_identical(res$character, df$character)
  expect_identical(res$logical, df$logical)

  expect_true(all(sapply(res[c("small_decimal", "large_number", "scientific")], is.character)))
})

test_that("sigfig_override and sigfig work as expected", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()

  x <- data.frame(x = "a", y = 0.015859)
  x2 <- data.frame(x = "b", y = 2025)
  subfoldr2::sbf_save_table(x, x_name = "coef")
  subfoldr2::sbf_save_table(x2, x_name = "glance")

  txt <- sbr_tables()
  expect_identical(txt, "\nTable 1.\n\n|x  |       y|\n|:--|-------:|\n|a  | 0.01586|\n\nTable 2.\n\n|x  |    y|\n|:--|----:|\n|b  | 2025|\n")

  txt <- sbr_tables(sigfig = 1)
  expect_identical(txt, "\nTable 1.\n\n|x  |    y|\n|:--|----:|\n|a  | 0.02|\n\nTable 2.\n\n|x  |    y|\n|:--|----:|\n|b  | 2000|\n")

  txt <- sbr_tables(sigfig = 1, sigfig_override = c("coef" = 3))
  expect_identical(txt, "\nTable 1.\n\n|x  |      y|\n|:--|------:|\n|a  | 0.0159|\n\nTable 2.\n\n|x  |    y|\n|:--|----:|\n|b  | 2000|\n")

  txt <- sbr_tables(sigfig = 1, sigfig_override = c("coef" = 4, "glance" = 3))
  expect_identical(txt, "\nTable 1.\n\n|x  |       y|\n|:--|-------:|\n|a  | 0.01586|\n\nTable 2.\n\n|x  |    y|\n|:--|----:|\n|b  | 2020|\n")
})
