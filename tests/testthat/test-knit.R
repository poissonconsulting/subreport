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
  
  data <- data.frame(x = 1, y = 2)
  x <- ggplot2::ggplot(data = data, ggplot2::aes(x = x, y = y)) 
  subfoldr2::sbf_save_plot(x, width = 3, caption = "A ggplot")

  file <- file.path(dir, "res")
  
  expect_identical(sbr_knit_results(file, browse = FALSE, quiet = TRUE),
                   paste0(file, ".Rmd"))
  
  expect_identical(sort(list.files(dir)), sort(c("report", "res.html", "res.Rmd")))
  
  skip("opens window")

  subfoldr2::sbf_open_window()
  plot(x~y, data = data.frame(x = c(5,4), y = c(6,7)))
  subfoldr2::sbf_save_window(width = 4, dpi  = 300L)
  subfoldr2::sbf_close_window()
  
  sbr_knit_results()
})