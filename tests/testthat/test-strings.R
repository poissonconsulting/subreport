test_that("strings", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()

  y <- "an assumption"
  subfoldr2::sbf_save_string(y, tag = "assumption")

  expect_identical(sbr_string("y"), "an assumption")

  txt <- sbr_strings()
  expect_identical(txt, "\n- an assumption\n")

  x <- "another assumption"
  subfoldr2::sbf_save_string(x, tag = "assumption")
  txt <- sbr_strings()
  expect_identical(txt, "\n- another assumption\n- an assumption\n")

  subfoldr2::sbf_save_string("not an assumption", "z")
  txt2 <- sbr_strings(tag = "assumption")
  expect_identical(txt2, txt)

  txt <- sbr_strings()
  expect_identical(txt, "\n- another assumption\n- an assumption\n- not an assumption\n")

  txt <- sbr_strings(numbered = TRUE)
  expect_identical(txt, "\n1. another assumption\n2. an assumption\n3. not an assumption\n")

  txt <- sbr_strings(tag = "assumption", numbered = TRUE)
  expect_identical(txt, "\n1. another assumption\n2. an assumption\n")

  t <- "from another city"
  subfoldr2::sbf_save_string(t, sub = "tori")
  txt <- sbr_strings()
  expect_identical(txt, "\n- another assumption\n- an assumption\n- not an assumption\n\n#### Tori\n\n- from another city\n")

  txt <- sbr_strings(numbered = TRUE)
  expect_identical(txt, "\n1. another assumption\n2. an assumption\n3. not an assumption\n\n#### Tori\n\n1. from another city\n")
})
