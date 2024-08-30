withr::local_envvar(
  list(CLIPR_ALLOW = TRUE),
  .local_envir = teardown_env()
)
