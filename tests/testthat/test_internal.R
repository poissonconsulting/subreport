test_that("set_headings correctly removes duplicate headings within a section", {

  data <- data.frame(
    sub1 = c("H1", "H2", "H3"),
    sub2 = c("Sh1", "Sh1", "H3"),
    sub3 = c("Ssh1", "Sh1", "H3")
  )

  expect_identical(
    set_headings(data, nheaders = nrow(data), header1 = 4L),
    data.frame(
      sub1 = c("H1", "H2", "H3"),
      sub2 = c("Sh1", "Sh1", "H3"),
      sub3 = c("Ssh1", "Sh1", "H3"),
      heading = c("\n#### H1\n\n##### Sh1\n\n###### Ssh1\n",
                  "\n#### H2\n\n##### Sh1\n", "\n#### H3\n"))
  )
})
  
test_that("set_headings correctly removes duplicate headings across sections", {

  data <- data.frame(
    sub1 = c(rep("H", 6), rep("H2", 6)),
    sub2 = rep(c(rep("Sh", 3), rep("Sh2", 3)), 2),
    sub3 = c(rep(c("Ssh", "Ssh2", "Ssh3"), 3), "Ssh", "Ssh", "Ssh2")
  )
  
  expect_identical(
    set_headings(data, nheaders = nrow(data), header1 = 4L),
    data.frame(
      sub1 = c("H", "H", "H", "H", "H", "H", "H2", "H2", "H2", "H2", "H2", "H2"),
      sub2 = c("Sh", "Sh", "Sh", "Sh2", "Sh2", "Sh2", "Sh", "Sh", "Sh", "Sh2",
               "Sh2", "Sh2"),
      sub3 = c("Ssh", "Ssh2", "Ssh3", "Ssh", "Ssh2", "Ssh3", "Ssh", "Ssh2",
               "Ssh3", "Ssh", "Ssh", "Ssh2"),
      heading = c("\n#### H\n\n##### Sh\n\n###### Ssh\n", "\n###### Ssh2\n",
                  "\n###### Ssh3\n", "\n##### Sh2\n\n###### Ssh\n",
                  "\n###### Ssh2\n", "\n###### Ssh3\n",
                  "\n#### H2\n\n##### Sh\n\n###### Ssh\n", "\n###### Ssh2\n",
                  "\n###### Ssh3\n", "\n##### Sh2\n\n###### Ssh\n", "",
                  "\n###### Ssh2\n")
    )
  )
})
