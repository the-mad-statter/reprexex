test_that("remove_function_call_from_code", {
  expect_equal(
    {
      c(
        "library(table1)",
        "as_img(table1(~ mpg, data = mtcars))"
      ) |>
        remove_function_call_from_code(call = "as_img")
    },
    {
      c(
        "library(table1)",
        "table1(~ mpg, data = mtcars)"
      )
    }
  )
})

test_that("remove_function_call_from_clip", {
  skip_if_not(clipr::clipr_available(), message = clipr::dr_clipr())
  expect_equal(
    {
      c(
        "library(table1)",
        "as_img(table1(~ mpg, data = mtcars))"
      ) |>
        clipr::write_clip()

      remove_function_call_from_clip()

      clipr::read_clip()[1:2]
    },
    {
      c(
        "library(table1)",
        "table1(~ mpg, data = mtcars)"
      )
    }
  )
})

test_that("remove_library_call_from_code", {
  expect_equal(
    {
      c(
        "library(reprexex)",
        "library(table1)",
        "as_img(table1(~ mpg, data = mtcars))"
      ) |>
        remove_library_call_from_code("reprexex")
    },
    {
      c(
        "library(table1)",
        "as_img(table1(~ mpg, data = mtcars))"
      )
    }
  )
})

test_that("", {
  skip_if_not(clipr::clipr_available(), message = clipr::dr_clipr())
  expect_equal(
    {
      c(
        "library(reprexex)",
        "library(table1)",
        "as_img(table1(~ mpg, data = mtcars))"
      ) |>
        clipr::write_clip()

      remove_library_call_from_clip()

      clipr::read_clip()[1:2]
    },
    {
      c(
        "library(table1)",
        "as_img(table1(~ mpg, data = mtcars))"
      )
    }
  )
})
