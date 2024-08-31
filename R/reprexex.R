#' @inherit reprex::opt
#' @param x option value
#' @param opt_name option name
opt <- function(x, opt_name = NA_character_) {
  if (!is.na(opt_name)) {
    attr(x, "opt_name") <- opt_name
  }
  attr(x, "optional") <- TRUE
  x
}

#' Render a reprex
#'
#' @description
#' A post processor for [reprex::reprex()]. First runs [reprex::reprex()]. Then
#' Removes the `library(reprexex)` and [as_img()] calls from the clipboard
#' contents. Finally re-renders the html preview if requested.
#'
#'
#' @param html_preview Logical. Whether to show rendered output in a viewer
#' (RStudio or browser). Always FALSE in a noninteractive session. Read more
#' about [opt()].
#' @param ... additional arguments passed to [reprex::reprex()]
#'
#' @return Character vector of rendered reprex, invisibly.
#' @export
#'
#' @examples
#' \dontrun{
#' library(clipr)
#'
#' c(
#'   "library(reprexex)",
#'   "library(table1)",
#'   "",
#'   "as_img(table1(~ mpg, data = mtcars))"
#' ) |>
#'   write_clip()
#'
#' reprexex()
#' }
#' @seealso [reprex::reprex()]
reprexex <- function(html_preview = opt(TRUE), ...) {
  # examples set to dontrun because see issue in as_img

  reprex::reprex(html_preview = html_preview, ...)

  remove_library_call_from_clip()
  remove_function_call_from_clip()

  if (interactive() && html_preview) {
    md_file <- tempfile(fileext = ".md")
    writeLines(clipr::read_clip(), md_file)
    rmarkdown::render(
      md_file,
      rmarkdown::html_document(pandoc_args = c("--metadata", "title= ")),
      quiet = TRUE
    )
    html_file <- sub("\\.md$", ".html", md_file)
    rstudioapi::viewer(html_file)
  }
}
