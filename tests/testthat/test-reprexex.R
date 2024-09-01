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
  if (!clipr::clipr_available()) {
    skip(clipr::dr_clipr())
  }

  c(
    "library(reprexex)",
    "library(table1, warn.conflicts = FALSE)",
    "",
    "as_img(table1(~ mpg, data = mtcars))"
  ) |>
    clipr::write_clip()

  reprexex()

  clip <- clipr::read_clip() |>
    clean_clip()

  expect_equal(
    {
      clip[1:6]
    },
    {
      c(
        "``` r",
        "library(table1, warn.conflicts = FALSE)",
        "",
        "table1(~ mpg, data = mtcars)",
        "```",
        ""
      )
    }
  )

  testthat::expect_match(
    {
      clip[7]
    },
    {
      '<img src="https://i.imgur.com/.+\\.png" width="\\d+" />'
    }
  )

  expect_equal(
    {
      clip[8]
    },
    {
      ""
    }
  )

  expect_match(
    {
      clip[9]
    },
    {
      paste0(
        "<sup>Created on \\d{4}-\\d{2}-\\d{2} with \\[reprex v\\d",
        "\\.\\d\\.\\d\\]\\(https://reprex\\.tidyverse\\.org\\)</sup>"
      )
    }
  )
})
