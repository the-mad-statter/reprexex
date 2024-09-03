withr::local_envvar(
  list(CLIPR_ALLOW = TRUE),
  .local_envir = teardown_env()
)

# number of test attempts per batch
try_max <- 10

#' Clean Clip
#'
#' Sometimes [clipr::read_clip]` returns extra content. This function removes
#' any extra content by extracting only characters expected for existing tests.
#'
#' @param x clip to clean
#' @param lines lines to subset
#'
#' @return a character vector containing only expected characters
clean_clip <- function(x, lines = seq_along(x)) {
  stringr::str_extract(x, '[ -_<>\\[\\]()~,.":/=a-z0-9`]*')[lines]
}
