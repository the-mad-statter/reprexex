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

  expect_gte(
    {
      purrr::map(1:try_max, ~ {
        c(
          "library(reprexex)",
          "library(table1, warn.conflicts = FALSE)",
          "",
          "as_img(table1(~ mpg, data = mtcars))"
        ) |>
          clipr::write_clip()

        reprexex()

        clipr::read_clip() |>
          clean_clip()
      }) |>
        purrr::map_lgl(\(try_output) {
          all(
            try_output[1] == "``` r",
            try_output[2] == "library(table1, warn.conflicts = FALSE)",
            try_output[3] == "",
            try_output[4] == "table1(~ mpg, data = mtcars)",
            try_output[5] == "```",
            try_output[6] == "",
            try_output[7] |> stringr::str_detect(paste0(
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
            )),
            try_output[8] == "",
            try_output[9] |> stringr::str_detect(paste0(
              "<sup>Created on \\d{4}-\\d{2}-\\d{2} with \\[reprex v\\d",
              "\\.\\d\\.\\d\\]\\(https://reprex\\.tidyverse\\.org\\)</sup>"
            ))
          )
        }) |>
        sum() / try_max
    },
    {
      1 / try_max
    }
  )
})
