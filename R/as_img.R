#' As Image
#'
#' @param x object to convert to image
#' @param ... additional arguments
#'
#' @export
#'
#' @examples
#' library(table1)
#'
#' as_img(table1(~mpg, data = mtcars))
as_img <- function(x, ...) {
  UseMethod("as_img")
}

#' @exportS3Method reprexex::as_img
as_img.default <- function(x, ...) {
  rmd_file <- system.file(
    "as_img/template.Rmd",
    package = "reprexex"
  )
  png_file <- tempfile(fileext = ".png")
  utils::capture.output(
    suppressMessages(
      webshot::rmdshot(
        rmd_file,
        png_file,
        rmd_args = list(params = list(x = x))
      )
    )
  )

  png_file |>
    magick::image_read() |>
    magick::image_trim() |>
    print(info = FALSE)

  closeAllConnections() # webshot leaves custom stdin and stdout open
}

#' @exportS3Method reprexex::as_img
as_img.table1 <- function(x, ...) {
  as_img.default(x, ...)
}
