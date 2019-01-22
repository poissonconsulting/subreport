context("knit")

test_that("tables", {

  dir <- file.path(tempdir(), "knit")
  unlink(dir)

  teardown(subfoldr2::sbf_reset_main())
  subfoldr2::sbf_set_main(tempdir(), "output", rm = TRUE, ask = FALSE)

  x <- data.frame(obs = "JD", count = 1L)
  subfoldr2::sbf_save_table(x, sub = "A header", caption = "Observations")

  y <- "
  model {
    for(i in 1:N)
      bEffect ~ dnorm(0, 2^-2)
  }"
  subfoldr2::sbf_save_block(y, caption = "jags")
  
  file <- file.path(dir, "res")
  
  expect_identical(sbr_knit_report(file, browse = FALSE, quiet = TRUE),
                   paste0(file, ".Rmd"))
  
  expect_identical(sort(list.files(dir)), sort(c("report", "res.html", "res.Rmd")))
  
  skip("knit locally")
  sbr_knit_report()
})
