context("knit")

test_that("tables", {
  teardown(sbr_reset_report())

  sbr_set_report(tempdir(), "report", rm = TRUE, ask = FALSE)
 
  sbr_set_report("report", rm = TRUE, ask = FALSE)
   
  x <- data.frame(obs = "JD", count = 1L)
  subfoldr2::sbf_get_main()
  subfoldr2::sbf_get_sub()

  subfoldr2::sbf_save_table(x, caption = "Observations")
  
  
  sbr_knit_report()
})
