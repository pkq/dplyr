test_that("can work directly with DBI connection", {
  skip_if_not_installed("RSQLite")
  skip_if_not_installed("dbplyr")

  con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
  on.exit(DBI::dbDisconnect(con))

  df <- tibble(x = 1:10, y = letters[1:10])
  df1 <- copy_to(con, df)
  df2 <- tbl(con, "df")

  expect_equal(collect(df1), df, ignore_attr = TRUE)
  expect_equal(collect(df2), df, ignore_attr = TRUE)
})
