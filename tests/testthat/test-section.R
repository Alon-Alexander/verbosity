with_mocked_sys_time <- function(elapsed_secs, code) {
  t0 <- as.POSIXct("2020-01-01 00:00:00", tz = "UTC")
  i <- 0L
  with_mocked_bindings(
    Sys.time = function() {
      res <- t0 + elapsed_secs * i
      i <<- i + 1L
      res
    },
    code = code,
    .package = "base"
  )
}

test_that("section returns the value of the last expression", {
  with_mocked_sys_time(1, {
    ret <- NULL
    capture.output(ret <- section("job", {
      cat("hi\n")
      1 + 1
    }))
    expect_equal(ret, 2)
  })
})

test_that("section logs elapsed seconds from Sys.time", {
  out <- with_mocked_sys_time(2.5, capture.output(section("job", {
    invisible(NULL)
  })))
  expect_equal(out, c("Start section job", "Section job done in 2.50s"))
})

test_that("section auto-prints visible results", {
  printed <- capture.output(print(head(mtcars, 1)))
  out <- with_mocked_sys_time(2.5, capture.output(section("job", head(mtcars, 1))))
  expect_equal(
    out,
    c("Start section job", paste0("    ", printed), "Section job done in 2.50s")
  )
})

test_that("section does not auto-print invisible results", {
  out <- with_mocked_sys_time(2.5, capture.output(section("job", {
    x <- 1 + 1
  })))
  expect_equal(out, c("Start section job", "Section job done in 2.50s"))
})

test_that("section indents captured stdout from the block", {
  out <- with_mocked_sys_time(2.5, capture.output(section("job", {
    cat("Hello, world!\ntwo lines\n")
    cat("more\n")
  })))
  expect_equal(
    out,
    c(
      "Start section job",
      "    Hello, world!",
      "    two lines",
      "    more",
      "Section job done in 2.50s"
    )
  )
})

test_that("section evaluates code_block in the caller", {
  x <- 1
  with_mocked_sys_time(1, {
    capture.output(section("inc", {
      x <- x + 1
    }))
  })
  expect_equal(x, 2)
})

test_that("section writes to stdout not stderr", {
  msgs <- NULL
  capture.output(msgs <- capture_messages(section("job", {
    cat("hi\n")
  })))
  expect_equal(msgs, character(0))
})

test_that("section restores the sink if the block errors", {
  n <- sink.number()
  expect_error(
    capture.output(section("bad", {
      cat("before\n")
      stop("boom")
    })),
    "boom",
    fixed = TRUE
  )
  expect_equal(sink.number(), n)
})

test_that("section indents recursively", {
  out <- with_mocked_sys_time(2.5, capture.output(section("outer", {
    cat("Hello, world!\ntwo lines\n")
    cat("more\n")
    section("inner", {
      cat("inner log\n")
    })
  })))
  expect_equal(
    out,
    c(
      "Start section outer",
      "    Hello, world!",
      "    two lines",
      "    more",
      "    Start section inner",
      "        inner log",
      "    Section inner done in 2.50s",
      "Section outer done in 7.50s"
    )
  )
})
