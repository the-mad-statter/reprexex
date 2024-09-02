withr::local_envvar(
  list(CLIPR_ALLOW = TRUE),
  .local_envir = teardown_env()
)

#' Read Clean Clip
#'
#' Sometimes [clipr::read_clip]` returns extra characters. This function
#' extracts only characters expected for existing tests.
#'
#' @return a character vector containing only expected characters
read_clean_clip <- function() {
  x <- tryCatch(
    {
      clipr::read_clip()
    },
    error = function(cond) {
      message <- conditionMessage(cond)
      if (stringr::str_detect(message, "unpaired surrogate Unicode point")) {
        suppressWarnings(
          clipr::read_clip()
        )
      } else {
        clipr::read_clip()
      }
    }
  )

  stringr::str_extract(x, '[ -_<>\\[\\]()~,.":/=a-z0-9`]*')
}

#' Safely Expect Equal
#' @inherit testthat::expect_equal
safely_expect_equal <- purrr::safely(expect_equal)

#' Safely Expect Match
#' @inherit testthat::expect_match
safely_expect_match <- purrr::safely(expect_match)

#' Proportion of Successes
#'
#' Sometimes [clipr::read_clip]` returns extra characters. Because this issue
#' appears to be random and leads to failed tests, some tests are run as
#' replicate batches. If a sufficient proportion of replicates are successful,
#' the batch is considered a success. This function calculates the proportion
#' of successes for the batch.
#'
#' @param try_results a list of replicated test results; each result consists
#' of a result and error slot
#'
#' @return proportion of successes
p_success <- function(try_results) {
  try_errors <- purrr::map(try_results, \(r) purrr::pluck(r, "error"))
  n_success <- sum(purrr::map_lgl(try_errors, \(e) is.null(e)))
  try_max <- length(try_results)
  if (n_success != try_max) {
    warning(sprintf("%i of %i attempts succeeded.", n_success, try_max))
  }
  n_success / try_max
}
