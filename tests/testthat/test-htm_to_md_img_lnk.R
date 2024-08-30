test_that("htm_to_md_img_lnk", {
  expect_s3_class(htm_to_md_img_lnk("Hello World!"), "magick-image")
})
