test_that("title prints two empty lines and a centered banner", {
  out <- capture.output(title("Hi", width = 10))
  expect_equal(out, c("", "", "=== Hi ==="))
})

test_that("title centers with uneven padding", {
  out <- capture.output(title("Hi", width = 11))
  expect_equal(out[[3]], "=== Hi ====")
})

test_that("title uses fixed padding when label exceeds width", {
  out <- capture.output(title("Hello", width = 3))
  expect_equal(out[[3]], "=== Hello ===")
})

test_that("title defaults width to cli::console_width()", {
  with_mocked_bindings(
    console_width = function() 12L,
    out <- capture.output(title("Go")),
    .package = "cli"
  )
  expect_equal(out[[3]], "==== Go ====")
})

test_that("title rejects invalid width", {
  expect_error(title("x", width = 0), "`width` must be a positive integer")
})

test_that("title returns label invisibly", {
  ret <- NULL
  capture.output(ret <- title("x", width = 5))
  expect_identical(ret, "x")
})

test_that("title writes to stdout not stderr", {
  msgs <- NULL
  capture.output(msgs <- capture_messages(title("Hi", width = 10)))
  expect_equal(msgs, character(0))
})
