test_that("numbers", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  subfoldr2::sbf_reset_sub()

  y <- "an assumption"
  subfoldr2::sbf_save_number(1, "indx")

  expect_identical(sbr_number("indx"), 1)

  txt <- sbr_numbers()
  expect_identical(txt, "\n- indx: 1\n")

  x <- "another assumption"
  subfoldr2::sbf_save_number(1.5, tag = "assumption")
  txt <- sbr_numbers(tag = "assumption")
  expect_identical(txt, "\n- 1.5: 1.5\n")

  subfoldr2::sbf_save_number(-0.1, "z")
  txt2 <- sbr_numbers(tag = "assumption")
  expect_identical(txt2, txt)

  txt <- sbr_numbers()
  expect_identical(txt, "\n- 1.5: 1.5\n- indx: 1\n- z: -0.1\n")

  txt <- sbr_numbers(numbered = TRUE)
  expect_identical(txt, "\n1. 1.5: 1.5\n2. indx: 1\n3. z: -0.1\n")

  txt <- sbr_numbers(tag = "assumption", numbered = TRUE)
  expect_identical(txt, "\n1. 1.5: 1.5\n")

  t <- 10^6
  subfoldr2::sbf_save_number(t, sub = "tori")
  txt <- sbr_numbers()
  expect_identical(txt, "\n- 1.5: 1.5\n- indx: 1\n- z: -0.1\n\n#### Tori\n\n- t: 1e+06\n")

  txt <- sbr_numbers(numbered = TRUE)
  expect_identical(txt, "\n1. 1.5: 1.5\n2. indx: 1\n3. z: -0.1\n\n#### Tori\n\n1. t: 1e+06\n")
})
