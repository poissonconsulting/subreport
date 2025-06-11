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
      heading = c("\n#### H1\n\n##### Sh1\n\n###### Ssh1\n", "\n#### H2\n\n##### Sh1\n", "\n#### H3\n"))
  )
})
  
test_that("set_headings correctly removes duplicate headings across sections", {

  data <- data.frame(
    sub1 = c("H", "H", "H", "H1", "H"),
    sub2 = c("Sh", "Sh", "Sh1", "Sh", "Sh"),
    sub3 = c("Ssh", "Ssh", "Ssh", "Ssh", "Ssh")
  )
  
  expect_identical(
    set_headings(data, nheaders = nrow(data), header1 = 4L),
    data.frame(
      sub1 = c("H", "H", "H", "H1", "H"),
      sub2 = c("Sh", "Sh", "Sh1", "Sh", "Sh"),
      sub3 = c("Ssh", "Ssh", "Ssh", "Ssh", "Ssh"),
      heading = c("\n#### H\n\n##### Sh\n\n###### Ssh\n", "", "\n##### Sh1\n\n###### Ssh\n", "\n#### H1\n\n##### Sh\n\n###### Ssh\n", "")
    )
  )
})
