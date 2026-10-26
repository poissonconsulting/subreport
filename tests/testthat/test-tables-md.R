test_that("sbr_tables md uses md files, sigfig_override and sigfig fallback", {
  local_edition(3)
  withr::local_options(sbr.pre_num_tab = NULL)
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()
  withr::defer(sbf_reset_sub())

  x <- data.frame(
    term = c("a", "b"),
    estimate = c(0.53124, 12.4321),
    sd = c(0.16123, 1.8)
  )
  subfoldr2::sbf_save_table(x, x_name = "coef", sub = "fish")
  subfoldr2::sbf_save_table(x, x_name = "coef2", sub = "fish")
  withr::with_options(
    list(sbf.save_md = FALSE),
    subfoldr2::sbf_save_table(
      data.frame(y = 0.015859),
      x_name = "glance",
      sub = "fish"
    )
  )

  expect_snapshot({
    cat(sbr_tables(md = TRUE, sigfig_override = c(coef2 = 2), pre_num = 0L))
  })
  expect_identical(
    sbr_tables(md = FALSE, pre_num = 0L),
    sbr_tables(pre_num = 0L)
  )
})

test_that("sbr_tables md finds md files when sub is supplied", {
  local_edition(3)
  withr::local_options(sbr.pre_num_tab = NULL)
  path <- withr::local_tempdir()
  subfoldr2::sbf_set_main(path, "output", rm = TRUE, ask = FALSE)
  sbr_set_report(path, "report", rm = TRUE, ask = FALSE)
  sbf_reset_sub()
  withr::defer(sbf_reset_sub())

  x <- data.frame(x = c(1.5, 12))
  subfoldr2::sbf_save_table(x, sub = c("a", "b"))
  subfoldr2::sbf_save_table(x, sub = "a")
  expect_snapshot(cat(sbr_tables(sub = "a", md = TRUE, pre_num = 0L)))
})

test_that("sbr_tables md must be a flag", {
  expect_error(sbr_tables(md = NA), class = "chk_error")
})
