with_mocked_sys_time <- function(elapsed_secs, code) {
  t0 <- as.POSIXct("2020-01-01 00:00:00", tz = "UTC")
  i <- 0L
  with_mocked_bindings(
    Sys.time = function() {
      i <<- i + 1L
      c(t0, t0 + elapsed_secs)[[i]]
    },
    code = code,
    .package = "base"
  )
}

test_that("log_time returns the value of expr", {
  with_mocked_sys_time(1, {
    expect_equal(suppressMessages(log_time("job", 1 + 1)), 2)
  })
})

test_that("log_time logs elapsed seconds from Sys.time", {
  msgs <- with_mocked_sys_time(2.5, {
    capture_messages(log_time("job", NULL))
  })
  expect_equal(msgs, c("[job] start\n", "[job] done in 2.50s\n"))
})

test_that("log_time evaluates expr in the caller", {
  x <- 1
  with_mocked_sys_time(1, {
    suppressMessages(log_time("inc", x <- x + 1))
  })
  expect_equal(x, 2)
})
