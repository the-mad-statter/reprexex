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

  try_max <- 10

  reprexex_input <- c(
    "library(reprexex)",
    "library(table1, warn.conflicts = FALSE)",
    "",
    "as_img(table1(~ mpg, data = mtcars))"
  )

  expect_gte(
    {
      try_results <- purrr::map(1:try_max, ~ {
        reprexex_input |>
          clipr::write_clip()

        reprexex()

        safely_expect_equal(
          {
            read_clean_clip()[1:6]
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
      })

      p_success(try_results)
    },
    {
      1 / try_max
    }
  )

  expect_gte(
    {
      try_results <- purrr::map(1:try_max, ~ {
        reprexex_input |>
          clipr::write_clip()

        reprexex()

        safely_expect_match(
          {
            read_clean_clip()[7]
          },
          {
            paste0(
              "(",
              '<img src="',
              "|",
              "!\\[\\]\\(",
              ")",
              "https://i.imgur.com/.+\\.png",
              "(",
              '" width="\\d+" />',
              "|",
              "\\)",
              ")"
            )
          }
        )
      })

      p_success(try_results)
    },
    {
      1 / try_max
    }
  )

  expect_gte(
    {
      try_results <- purrr::map(1:try_max, ~ {
        reprexex_input |>
          clipr::write_clip()

        reprexex()

        safely_expect_equal(
          {
            read_clean_clip()[8]
          },
          {
            ""
          }
        )
      })

      p_success(try_results)
    },
    {
      1 / try_max
    }
  )

  expect_gte(
    {
      try_results <- purrr::map(1:try_max, ~ {
        reprexex_input |>
          clipr::write_clip()

        reprexex()

        safely_expect_match(
          {
            read_clean_clip()[9]
          },
          {
            paste0(
              "<sup>Created on \\d{4}-\\d{2}-\\d{2} with \\[reprex v\\d",
              "\\.\\d\\.\\d\\]\\(https://reprex\\.tidyverse\\.org\\)</sup>"
            )
          }
        )
      })

      p_success(try_results)
    },
    {
      1 / try_max
    }
  )
})
