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
  expect_identical(
    txt,
    "\n- 1.5: 1.5\n- indx: 1\n- z: -0.1\n\n#### Tori\n\n- t: 1e+06\n"
  )

  txt <- sbr_numbers(numbered = TRUE)
  expect_identical(
    txt,
    "\n1. 1.5: 1.5\n2. indx: 1\n3. z: -0.1\n\n#### Tori\n\n1. t: 1e+06\n"
  )
})

test_that("numbers drop", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  subfoldr2::sbf_reset_sub()

  subfoldr2::sbf_save_number(1, "x", sub = "a")
  subfoldr2::sbf_save_number(2, "x", sub = "b")

  expect_identical(sbr_numbers(drop = "b"), "\n#### A\n\n- x: 1\n")
  expect_identical(sbr_numbers(drop = c("a", "b")), character(0))
})

test_that("numbers rename can combine sub folders", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  subfoldr2::sbf_reset_sub()

  subfoldr2::sbf_save_number(1, "a", sub = "auc")
  subfoldr2::sbf_save_number(2, "b", sub = "fecundity")
  subfoldr2::sbf_save_number(3, "c", sub = "spawner-timing")
  subfoldr2::sbf_save_number(4, "d", sub = c("growth", "auc"))
  subfoldr2::sbf_save_number(5, "e", sub = c("growth", "length"))
  subfoldr2::sbf_save_number(6, "f", sub = c("growth", "spawner-timing"))

  rename <- c("auc" = "Spawner Timing", "spawner-timing" = "Spawner Timing")
  expect_identical(
    sbr_numbers(rename = rename),
    "\n#### Spawner Timing\n\n- a: 1\n- c: 3\n\n#### Fecundity\n\n- b: 2\n\n#### Growth\n\n##### Spawner Timing\n\n- d: 4\n- f: 6\n\n##### Length\n\n- e: 5\n"
  )
})
