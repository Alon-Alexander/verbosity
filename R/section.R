#' Run a block of code with nice output wrapping.
#'
#' Evaluates each statement in `code_block` in the calling environment.
#' Printed output from the block is captured and re-emitted indented.
#' Prints start and done messages with elapsed seconds, and returns
#' the result of the last statement.
#'
#' @param label A character string identifying the section.
#' @param code_block An expression or `{ ... }` block to evaluate.
#'
#' @return The result of the last expression in `code_block`.
#'
#' @examples
#' section("greet", {
#'   cat("hello\n")
#'   cat("world\n")
#' })
#' section("preview", head(mtcars, 2))
#'
#' @export
section <- function(label, code_block) {
  start <- Sys.time()
  cat(sprintf("Start section %s\n", label))

  con <- textConnection("captured_text", "w", local = TRUE)
  sink(con)
  sink_open <- TRUE

  on.exit({
    if (sink_open) sink()
    try(close(con), silent = TRUE)
  })

  code_expr <- substitute(code_block)
  if (is.call(code_expr) && identical(code_expr[[1L]], quote(`{`))) {
    expressions <- as.list(code_expr)[-1L]
  } else {
    expressions <- list(code_expr)
  }

  result <- NULL
  for (expr in expressions) {
    vis <- withVisible(eval(expr, envir = parent.frame()))
    result <- vis$value
    if (vis$visible) {
      print(result)
    }

    flush(con)
    sink()
    sink_open <- FALSE
    new_lines <- textConnectionValue(con)
    close(con)

    if (length(new_lines) > 0) {
      cat(paste0("    ", new_lines, "\n"), sep = "")
      flush.console()
    }

    con <- textConnection("captured_text", "w", local = TRUE)
    sink(con)
    sink_open <- TRUE
  }

  sink()
  sink_open <- FALSE
  close(con)
  on.exit()

  elapsed <- as.numeric(difftime(Sys.time(), start, units = "secs"))
  cat(sprintf("Section %s done in %.2fs\n", label, elapsed))

  invisible(result)
}
