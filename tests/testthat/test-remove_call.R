remove_function_call_input <- c(
  "library(reprexex)",
  "library(table1, warn.conflicts = FALSE)",
  "",
  "as_img(table1(~ mpg, data = mtcars))"
)

remove_function_call_output <- c(
  "library(reprexex)",
  "library(table1, warn.conflicts = FALSE)",
  "",
  "table1(~ mpg, data = mtcars)"
)

test_that("remove_function_call_from_code", {
  expect_equal(
    {
      remove_function_call_input |>
        remove_function_call_from_code(call = "as_img")
    },
    {
      remove_function_call_output
    }
  )
})

test_that("remove_function_call_from_clip", {
  if (!clipr::clipr_available()) {
    skip(clipr::dr_clipr())
  }

  try_max <- 10

  testthat::expect_gte(
    {
      try_results <- purrr::map(1:try_max, ~ {
        safely_expect_equal(
          {
            remove_function_call_input |>
              clipr::write_clip()

            remove_function_call_from_clip()

            read_clean_clip()[1:4]
          },
          {
            remove_function_call_output
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

remove_library_call_input <- c(
  "library(reprexex)",
  "library(table1, warn.conflicts = FALSE)",
  "",
  "as_img(table1(~ mpg, data = mtcars))"
)

remove_library_call_output <- c(
  "library(table1, warn.conflicts = FALSE)",
  "",
  "as_img(table1(~ mpg, data = mtcars))"
)

test_that("remove_library_call_from_code", {
  expect_equal(
    {
      remove_library_call_input |>
        remove_library_call_from_code("reprexex")
    },
    {
      remove_library_call_output
    }
  )
})

test_that("remove_library_call_from_clip", {
  if (!clipr::clipr_available()) {
    skip(clipr::dr_clipr())
  }

  try_max <- 10

  testthat::expect_gte(
    {
      try_results <- purrr::map(1:try_max, ~ {
        safely_expect_equal(
          {
            remove_library_call_input |>
              clipr::write_clip()

            remove_library_call_from_clip()

            read_clean_clip()[1:3]
          },
          {
            remove_library_call_output
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
