#' Log size changes of a variable during an expression
#'
#' Evaluates `expr` in the calling environment, checks that `variable` is a
#' data frame or has length greater than one, verifies that the expression
#' result stays a data frame (or non-data frame), and logs row, column, or
#' length changes.
#'
#' @param label A character string identifying the filtered block.
#' @param variable A data frame or vector with length greater than one.
#' @param expr An expression to evaluate (typically modifying `variable`).
#'
#' @return The result of `expr`.
#'
#' @examples
#' df <- data.frame(x = 1:5, y = 6:10)
#' log_filter("subset rows", df, df <- df[1:3, ])
#'
#' @export
log_filter <- function(label, variable, expr) {
  var <- substitute(variable)
  if (!is.symbol(var)) {
    stop("`variable` must be a bare symbol", call. = FALSE)
  }

  env <- parent.frame()
  variable <- eval(var, env)

  if (!is.data.frame(variable) && length(variable) <= 1) {
    stop(
      "`variable` must be a data frame or have length greater than one",
      call. = FALSE
    )
  }

  was_data_frame <- is.data.frame(variable)
  start <- Sys.time()

  if (was_data_frame) {
    before_rows <- nrow(variable)
    before_cols <- ncol(variable)
  } else {
    before_len <- length(variable)
  }

  result <- eval(substitute(expr), env)

  if (was_data_frame != is.data.frame(result)) {
    stop(
      sprintf(
        "[%s] result must %sbe a data frame",
        label,
        if (was_data_frame) "" else "not "
      ),
      call. = FALSE
    )
  }

  variable <- eval(var, env)
  elapsed <- as.numeric(difftime(Sys.time(), start, units = "secs"))

  if (was_data_frame) {
    after_rows <- nrow(variable)
    after_cols <- ncol(variable)
    details <- character(0)
    if (before_rows != after_rows) {
      details <- c(details, sprintf("nrows: %d -> %d", before_rows, after_rows))
    }
    if (before_cols != after_cols) {
      details <- c(details, sprintf("ncols: %d -> %d", before_cols, after_cols))
    }
    if (length(details) == 0) {
      details <- "no change in size"
    }
  } else {
    after_len <- length(variable)
    details <- if (before_len != after_len) {
      sprintf("length: %d -> %d", before_len, after_len)
    } else {
      "no change in size"
    }
  }

  header <- sprintf('Filter of "%s" finished and took %.2fs', label, elapsed)
  body <- paste0("    ", details, collapse = "\n")
  message(paste(header, body, sep = "\n"))

  invisible(result)
}
