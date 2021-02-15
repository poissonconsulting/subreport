test_that("blocks", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()

  y <- "
  model {
    for(i in 1:N)
      bEffect ~ dnorm(0, 2^-2)
  }"
  subfoldr2::sbf_save_block(y, caption = "jags")
  
  txt <- sbr_blocks()
  expect_identical(txt, "\n```\n.\n  model {\n    for(i in 1:N)\n      bEffect ~ dnorm(0, 2^-2)\n  }\n..\n```\nBlock 1. jags.\n")
  expect_identical(sbr_blocks(x_name = "y"), txt)
  expect_identical(sbr_blocks(x_name = "z"), character(0))
  expect_identical(list.files(sbr_get_report(), recursive = TRUE), "blocks/y.txt")
  
  y_txt <- readLines(file.path(sbr_get_report(), "blocks/y.txt"))
  y_txt <- paste0(y_txt, collapse = "\n")
  expect_identical(y_txt, y)
})
