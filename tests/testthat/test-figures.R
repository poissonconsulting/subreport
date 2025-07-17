test_that("figures", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()

  data <- data.frame(x = 1, y = 2)
  x <- ggplot2::ggplot(data = data, ggplot2::aes(x = x, y = y))
  subfoldr2::sbf_save_plot(x, caption = "A ggplot")

  options(warn = 2)
  txt <- sbr_figures()
  expect_match(txt, "\n<figure>\n<img alt = \".*report/plots/x.png\" width = \"100%\">\n<figcaption>Figure 1. A ggplot.</figcaption>\n</figure>\n")
  expect_identical(
    sort(list.files(sbr_get_report(), recursive = TRUE)),
    sort(c("plots/x.csv", "plots/x.png"))
  )

  skip("opens window")
  subfoldr2::sbf_open_window()
  plot(x ~ y, data = data.frame(x = c(5, 4), y = c(6, 7)))
  subfoldr2::sbf_save_window(height = 7L, dpi = 300L)
  subfoldr2::sbf_close_window()

  txt <- sbr_figures()
  expect_match(txt, "\n<figure>\n<img alt = \".*plots/x.png\" width = \"100%\">\n<figcaption>Figure 2. A ggplot.</figcaption>\n</figure>\n")

  expect_identical(
    sort(list.files(sbr_get_report(), recursive = TRUE)),
    sort(c("plots/window.png", "plots/x.csv", "plots/x.png"))
  )

  subfoldr2::sbf_open_window()
  plot(x ~ y, data = data.frame(x = c(5, 4), y = c(6, 7)))
  subfoldr2::sbf_save_window(
    x_name = "x", width = 12L, dpi = 300L,
    caption = "the window one"
  )
  subfoldr2::sbf_close_window()

  txt <- sbr_figures()
  expect_match(txt, "\n<figure>\n<img alt = \".*plots/x.png\" width = \"200%\">\n<figcaption>Figure 2. the window one.</figcaption>\n</figure>\n")
  expect_identical(sbr_figures(x_name = ".*.*"), txt)
})

test_that("figures sort sub and name", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()

  data <- data.frame(x = 1, y = 2)
  allometry <- ggplot2::ggplot(data = data, ggplot2::aes(x = x, y = y))
  subfoldr2::sbf_save_plot(allometry, caption = "Length weight")

  data <- data.frame(x = 1:2, y = 3:4)
  standard <- ggplot2::ggplot(data = data, ggplot2::aes(x = x, y = y))

  subfoldr2::sbf_save_plot(standard, sub = "90 mm")

  txt <- sbr_figures(pre_num = 0L)
  expect_match(txt, "\n<figure>\n<img alt = .* width = \"100%\">\n<figcaption>Figure 1. Length weight.</figcaption>\n</figure>\n\n#### 90 Mm\n\n<figure>\n<img alt = .*report/plots/90 mm/standard.png\" width = \"100%\">\n<figcaption>Figure 2.</figcaption>\n</figure>\n")

  txt <- sbr_figures(
    sort = c("allometry", "90mm", "standard"),
    pre_num = 0L
  )

  expect_match(txt, "\n<figure>\n<img alt = .* width = \"100%\">\n<figcaption>Figure 1. Length weight.</figcaption>\n</figure>\n\n#### 90 Mm\n\n<figure>\n<img alt = .*report/plots/90 mm/standard.png\" width = \"100%\">\n<figcaption>Figure 2.</figcaption>\n</figure>\n")

  txt <- sbr_figures(x_name = "allometry", sort = c("allometry", "90 mm", "standard"), pre_num = 0L)

  expect_match(txt, "\n<figure>\n<img alt = .*report/plots//allometry.png\" width = \"100%\">\n<figcaption>Figure 1. Length weight.</figcaption>\n</figure>\n")
})

test_that("figures different sub lengths windows and plots", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()

  subfoldr2::sbf_set_sub("one", "two")

  data <- data.frame(x = 1, y = 2)
  allometry <- ggplot2::ggplot(data = data, ggplot2::aes(x = x, y = y))
  subfoldr2::sbf_save_plot(allometry, caption = "Length weight")

  skip("opens window")
  subfoldr2::sbf_open_window()
  plot(x ~ y, data = data.frame(x = c(5, 4), y = c(6, 7)))
  subfoldr2::sbf_set_sub("one", "two", "three")
  subfoldr2::sbf_save_window(height = 7L, dpi = 300L)
  subfoldr2::sbf_close_window()

  txt <- sbr_figures(x_name = "allometry")

  expect_match(txt, "\n#### One\n\n##### Two\n\n<figure>\n<img alt = .*report/plots/one/two/allometry.png\" src = .*report/plots/one/two/allometry.png\" title = .*report/plots/one/two/allometry.png\" width = \"100%\">\n<figcaption>Figure 1. Length weight.</figcaption>\n</figure>\n")

  txt <- sbr_figures()

  expect_match(txt, "\n#### One\n\n##### Two\n\n<figure>\n<img alt = .*report/plots/one/two/allometry.png\" src = .*report/plots/one/two/allometry.png\" title = .*report/plots/one/two/allometry.png\" width = \"100%\">\n<figcaption>Figure 1. Length weight.</figcaption>\n</figure>\n\n<figure>\n<img alt = .*report/plots/one/two/three/window.png\" src = .*report/plots/one/two/three/window.png\" title = .*report/plots/one/two/three/window.png\" width = \"100%\">\n<figcaption>Figure 2.</figcaption>\n</figure>\n")
})

test_that("figures pre_num", {
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()

  data <- data.frame(x = 1, y = 2)
  x <- ggplot2::ggplot(data = data, ggplot2::aes(x = x, y = y))
  subfoldr2::sbf_save_plot(x, caption = "A ggplot")

  options(warn = 2)
  txt <- sbr_figures(pre_num = 0)
  expect_match(txt, "\n<figure>\n<img alt = \".*report/plots/x.png\" width = \"100%\">\n<figcaption>Figure 1. A ggplot.</figcaption>\n</figure>\n")
  expect_identical(
    sort(list.files(sbr_get_report(), recursive = TRUE)),
    sort(c("plots/x.csv", "plots/x.png"))
  )
  txt <- sbr_figures()
  expect_match(txt, "\n<figure>\n<img alt = \".*report/plots/x.png\" width = \"100%\">\n<figcaption>Figure 2. A ggplot.</figcaption>\n</figure>\n")
  expect_identical(
    sort(list.files(sbr_get_report(), recursive = TRUE)),
    sort(c("plots/x.csv", "plots/x.png"))
  )
})
