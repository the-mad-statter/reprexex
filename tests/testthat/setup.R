withr::local_envvar(
  list(CLIPR_ALLOW = TRUE),
  .local_envir = teardown_env()
)

clean_clip <- function(x) {
  # mark empty lines
  x[x == ""] <- "<blank />"
  # extract expected characters
  x <- stringr::str_extract(x, '[ -_<>\\[\\]()~,.":/=a-z0-9`]*')
  # remove any empty lines created when removing characters
  x <- x[x != ""]
  # revert marked empty lines
  x[x == "<blank />"] <- ""
  # return clean
  x
}
