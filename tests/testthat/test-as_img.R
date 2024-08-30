test_that("as_img.default", {
  expect_null(as_img("<h1>Hello World!</h1>"))
})

test_that("as_img.table1", {
  expect_null({
    library(table1)
    as_img(table1(~mpg, data = mtcars))
  })
})
