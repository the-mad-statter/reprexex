withr::local_envvar(
  list(CLIPR_ALLOW = TRUE),
  .local_envir = teardown_env()
)

clean_clip <- function(x) {
  # mark empty lines
  x[x == ""] <- "<blank />"
  # remove undesired characters
  x <- gsub('[^ -<>\\[\\]()~,.":/=a-z0-9`]', "", x)
  # remove any empty lines created when removing characters
  x <- x[x != ""]
  # revert marked empty lines
  x[x == "<blank />"] <- ""
  # return clean
  x
}
