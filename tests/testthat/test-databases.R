context("databases")

test_that("databases", {
  teardown(subfoldr2::sbf_reset_main())
  teardown(sbr_reset_report())

  subfoldr2::sbf_set_main(tempdir(), "output", rm = TRUE, ask = FALSE)
  sbr_set_report(tempdir(), "report", rm = TRUE, ask = FALSE)
  
  x <- data.frame(x = 1)
  y <- data.frame(z = 3)

  conn <- subfoldr2::sbf_open_db(exists = NA, caption = "really!")
  teardown(suppressWarnings(DBI::dbDisconnect(conn)))

  DBI::dbGetQuery(conn, "CREATE TABLE x (
                  x INTEGER PRIMARY KEY NOT NULL)")
  
  DBI::dbGetQuery(conn, "CREATE TABLE y (
                  z INTEGER PRIMARY KEY NOT NULL)")
  
  expect_identical(subfoldr2::sbf_save_datas_to_db(
    env = as.environment(list(x = x, y = y))),
                   c("y", "x"))

  txt <- sbr_databases()
  
  expect_identical(txt, "\nDatabase 1. really!.\n\n|Table |Column |Meta |Description |\n|:-----|:------|:----|:-----------|\n|X     |X      |NA   |NA          |\n|Y     |Z      |NA   |NA          |\n")
})
