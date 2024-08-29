#' HTML to Markdown Image Link
#'
#' @param x html object to convert to image
#'
#' @export
htm_to_md_img_lnk <- function(x) {
  rmd_file <- system.file(
    "htm_to_md_img_lnk/template.Rmd",
    package = "reprexex"
  )
  png_file <- tempfile(fileext = ".png")
  nul <- utils::capture.output( # nolint
    suppressMessages(
      webshot::rmdshot(
        rmd_file,
        png_file,
        rmd_args = list(params = list(x = x))
      )
    )
  )

  img <- png_file |>
    magick::image_read() |>
    magick::image_trim()

  print(img)
}
