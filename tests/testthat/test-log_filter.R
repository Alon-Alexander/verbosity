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

expect_filter_message <- function(label, elapsed_secs, details, code) {
  msgs <- with_mocked_sys_time(elapsed_secs, {
    capture_messages(code)
  })
  expect_equal(
    msgs,
    c(
      sprintf(
        'Filter of "%s" finished and took %.2fs\n    %s\n',
        label,
        elapsed_secs,
        details
      )
    )
  )
}

test_that("log_filter returns the value of expr", {
  df <- data.frame(x = 1:5, y = 6:10)
  with_mocked_sys_time(1, {
    out <- suppressMessages(log_filter("job", df, df <- df[1:3, ]))
    expect_equal(out, df)
    expect_equal(nrow(df), 3)
  })
})

test_that("log_filter logs nrows changes for data frames", {
  df <- data.frame(x = 1:5, y = 6:10)
  expect_filter_message(
    "subset",
    2.5,
    "nrows: 5 -> 2",
    log_filter("subset", df, df <- df[1:2, ])
  )
})

test_that("log_filter logs ncols changes for data frames", {
  df <- data.frame(x = 1:3, y = 4:6, z = 7:9)
  expect_filter_message(
    "drop",
    2.5,
    "ncols: 3 -> 2",
    log_filter("drop", df, { df <- df[, 1:2] })
  )
})

test_that("log_filter logs both nrows and ncols when both change", {
  df <- data.frame(x = 1:4, y = 5:8, z = 9:12)
  expect_filter_message(
    "trim",
    2.5,
    "nrows: 4 -> 2\n    ncols: 3 -> 2",
    log_filter("trim", df, df <- df[1:2, 1:2])
  )
})

test_that("log_filter logs length changes for vectors", {
  x <- 1:5
  expect_filter_message(
    "slice",
    2.5,
    "length: 5 -> 2",
    log_filter("slice", x, x <- x[1:2])
  )
})

test_that("log_filter reports no change in size", {
  df <- data.frame(x = 1:3, y = 4:6)
  expect_filter_message(
    "noop",
    2.5,
    "no change in size",
    log_filter("noop", df, df <- df)
  )

  x <- 1:4
  expect_filter_message(
    "noop",
    2.5,
    "no change in size",
    log_filter("noop", x, invisible(x))
  )
})

test_that("log_filter requires a data frame or length > 1", {
  one <- 1
  empty <- character(0)
  expect_error(
    log_filter("bad", one, NULL),
    "`variable` must be a data frame or have length greater than one",
    fixed = TRUE
  )
  expect_error(
    log_filter("bad", empty, NULL),
    "`variable` must be a data frame or have length greater than one",
    fixed = TRUE
  )
})

test_that("log_filter accepts data frames regardless of length", {
  df <- data.frame()
  with_mocked_sys_time(1, {
    expect_equal(suppressMessages(log_filter("empty", df, df)), df)
  })
})

test_that("log_filter rejects data frame results for non-data frame variables", {
  x <- 1:3
  expect_error(
    log_filter("bad", x, data.frame(x = x)),
    "\\[bad\\] result must not be a data frame"
  )
})

test_that("log_filter rejects non-data frame results for data frames", {
  df <- data.frame(x = 1:3)
  expect_error(
    log_filter("bad", df, list(x = 1:2)),
    "\\[bad\\] result must be a data frame"
  )
})

test_that("log_filter allows class changes within the same kind", {
  x <- 1:3
  with_mocked_sys_time(1, {
    out <- suppressMessages(log_filter("cast", x, as.numeric(x)))
    expect_equal(out, as.numeric(x))
  })
})

test_that("log_filter evaluates expr in the caller", {
  df <- data.frame(x = 1:5, y = 6:10)
  n <- 2
  with_mocked_sys_time(1, {
    suppressMessages(log_filter("subset", df, df <- df[seq_len(n), ]))
  })
  expect_equal(nrow(df), 2)
})

test_that("log_filter requires variable to be a bare symbol", {
  expect_error(log_filter("bad", 1:3, NULL), "`variable` must be a bare symbol")
})
