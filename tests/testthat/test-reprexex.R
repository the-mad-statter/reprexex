test_that("opt", {
  expect_equal(
    {
      opt(TRUE)
    },
    {
      structure(TRUE, optional = TRUE)
    }
  )
})

test_that("reprexex", {
  expect_equal(
    {
      c(
        "library(reprexex)",
        "library(table1, warn.conflicts = FALSE)",
        "",
        "as_img(table1(~ mpg, data = mtcars))"
      ) |>
        clipr::write_clip()

      reprexex()

      clipr::read_clip()[1:4]
    },
    {
      c(
        "``` r",
        "library(table1, warn.conflicts = FALSE)",
        "",
        "table1(~ mpg, data = mtcars)"
      )
    }
  )
})
