context("plots")

test_that("plots", {
#  teardown(subfoldr2::sbf_reset_main())
#  teardown(sbr_reset_report())

#  subfoldr2::sbf_set_main(tempdir(), "output", rm = TRUE, ask = FALSE)
#  sbr_set_report(tempdir(), "report", rm = TRUE, ask = FALSE)

  data <- data.frame(x = 1, y = 2)
  x <- ggplot2::ggplot(data = data)
  subfoldr2::sbf_save_plot(x, caption = "A ggplot")
# 
#   txt <- sbr_plots()
#   expect_identical(txt, "\nTable 1. Observations.\n\n|obs | count|\n|:---|-----:|\n|JD  |     1|\n")
#   expect_identical(list.files(sbr_get_report(), recursive = TRUE), 
#                    c("plots/x.csv", "plots/x.png"))
})
