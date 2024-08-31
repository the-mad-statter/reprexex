#' Remove Function Call from Code
#'
#' @description
#' Remove the first function call from code. Will remove the call and both
#' open and trailing parentheses but will leave inner code if any.
#'
#' @param code code from which to remove function call
#' @param call function call to remove
#'
#' @return code with function call removed
#' @export
#'
#' @examples
#' c(
#'   "library(table1)",
#'   "",
#'   "as_img(table1(~ mpg, data = mtcars))"
#' ) |>
#'   remove_function_call_from_code(call = "as_img")
remove_function_call_from_code <- function(code, call) {
  code <- code |>
    paste(collapse = "\n")

  loc <- regexpr(call, code)
  loc_beg <- loc[[1]]
  loc_len <- attr(loc, "match.length")
  loc_end <- loc_beg + loc_len

  codechars <- strsplit(code, "")[[1]]

  p <- 0
  for (i in loc_end:length(codechars)) {
    if (codechars[i] == "(") {
      p <- p + 1
    }

    if (codechars[i] == ")") {
      p <- p - 1
    }

    if (p == 0) {
      break
    }
  }

  codechars[c(loc_beg:loc_end, i)] <- ""
  code <- paste(codechars, collapse = "")
  strsplit(code, "\n")[[1]]
}

#' Remove Function Call from Clip
#'
#' @description
#' Remove the first function call from code on the system clipboard. Will
#' remove the call and both open and trailing parentheses but will leave inner
#' code if any.
#'
#' @param call function call to remove
#'
#' @return invisibly returns clip code with function call removed
#' @export
#'
#' @examples
#' library(clipr)
#'
#' if (clipr_available() && Sys.getenv("CLIPR_ALLOW", interactive())) {
#'   c(
#'     "library(table1)",
#'     "",
#'     "as_img(table1(~ mpg, data = mtcars))"
#'   ) |>
#'     write_clip()
#'
#'   remove_function_call_from_clip()
#'
#'   read_clip()
#' }
remove_function_call_from_clip <- function(call = "as_img") {
  clipr::read_clip() |>
    remove_function_call_from_code(call) |>
    clipr::write_clip()
}

#' Remove Library Call from Code
#'
#' @param code code from which to remove library call
#' @param lib library for which to remove library call
#'
#' @return code with library call removed
#' @export
#'
#' @examples
#' c(
#'   "library(reprexex)",
#'   "library(table1)",
#'   "",
#'   "as_img(table1(~ mpg, data = mtcars))"
#' ) |>
#'   remove_library_call_from_code("reprexex")
remove_library_call_from_code <- function(code, lib) {
  code |>
    paste(collapse = "\n") |>
    sub(
      pattern = sprintf("library(%s)\n", lib),
      replacement = "",
      fixed = TRUE
    ) |>
    strsplit("\n") |>
    unlist()
}

#' Remove Library Call from Clip
#'
#' @param lib library for which to remove library call
#'
#' @return invisibly returns clip code with library call removed
#' @export
#'
#' @examples
#' library(clipr)
#'
#' if (clipr_available() && Sys.getenv("CLIPR_ALLOW", interactive())) {
#'   c(
#'     "library(reprexex)",
#'     "library(table1)",
#'     "",
#'     "as_img(table1(~ mpg, data = mtcars))"
#'   ) |>
#'     write_clip()
#'
#'   remove_library_call_from_clip()
#'
#'   read_clip()
#' }
remove_library_call_from_clip <- function(lib = "reprexex") {
  clipr::read_clip() |>
    remove_library_call_from_code(lib) |>
    clipr::write_clip()
}
