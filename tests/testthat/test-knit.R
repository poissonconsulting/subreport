test_that("tables", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", ask = FALSE)
  sbf_reset_sub()

  subfoldr2::sbf_save_string("this is an assumption", "x", tag = "assumption")
  subfoldr2::sbf_save_string("so is this", "y", tag = "assumption")
  subfoldr2::sbf_save_string("this is not", "z")

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

  x <- data.frame(x = 1)
  y <- data.frame(z = 3)

  expect_identical(
    sbr_knit_results(browse = FALSE, quiet = TRUE),
    "results.Rmd"
  )

  skip("opens window")

  subfoldr2::sbf_open_window()
  plot(x ~ y, data = data.frame(x = c(5, 4), y = c(6, 7)))
  subfoldr2::sbf_save_window(width = 4, dpi = 300L)
  subfoldr2::sbf_close_window()

  sbr_knit_results()
})
