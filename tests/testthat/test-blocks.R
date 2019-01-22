context("blocks")

test_that("blocks", {
  teardown(subfoldr2::sbf_reset_main())
  teardown(sbr_reset_report())

  subfoldr2::sbf_set_main(tempdir(), "output", rm = TRUE, ask = FALSE)
  sbr_set_report(tempdir(), "report", rm = TRUE, ask = FALSE)
  
  y <- "
  model {
    for(i in 1:N)
      bEffect ~ dnorm(0, 2^-2)
  }"
  subfoldr2::sbf_save_block(y, caption = "jags")
  
  txt <- sbr_blocks()
  expect_identical(txt, "\n```\n.\n  model {\n    for(i in 1:N)\n      bEffect ~ dnorm(0, 2^-2)\n  }\n..\n```\nBlock 1. jags.\n")
  expect_identical(list.files(sbr_get_report(), recursive = TRUE), "blocks/y.txt")
})
