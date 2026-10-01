#' Log elapsed time of an expression
#'
#' Evaluates `expr` in the calling environment, prints start and done messages
#' with elapsed seconds, and returns the result.
#'
#' @param label A character string identifying the timed block.
#' @param expr An expression to evaluate.
#'
#' @return The result of `expr`.
#'
#' @examples
#' log_time("sleep", Sys.sleep(0.1))
#'
#' @export
log_time <- function(label, expr) {
  start <- Sys.time()
  cat(sprintf("[%s] start\n", label))
  result <- eval.parent(substitute(expr))
  elapsed <- as.numeric(difftime(Sys.time(), start, units = "secs"))
  cat(sprintf("[%s] done in %.2fs\n", label, elapsed))
  invisible(result)
}
