context("knit")

test_that("tables", {

  dir <- file.path(tempdir(), "knit")
  unlink(dir)

  teardown(subfoldr2::sbf_reset_main())
  subfoldr2::sbf_set_main(tempdir(), "output", rm = TRUE, ask = FALSE)

  x <- data.frame(obs = "JD", count = 1L)
  subfoldr2::sbf_save_table(x, caption = "Observations")
  
  file <- file.path(dir, "res")
  
  expect_identical(sbr_knit_report(file, browse = FALSE, quiet = TRUE),
                   paste0(file, ".Rmd"))
  
  expect_identical(sort(list.files(dir)), sort(c("report", "res.html", "res.Rmd")))
})
