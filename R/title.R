#' Print a centered section title
#'
#' Prints two blank lines, then `label` centered in a row of `"="` characters.
#'
#' @param label A character string to display.
#' @param width Total width of the title row. Defaults to [cli::console_width()].
#'
#' @return Invisibly returns `label`.
#'
#' @examples
#' title("Section")
#' title("Section", width = 40)
#'
#' @export
title <- function(label, width = cli::console_width()) {
  label <- as.character(label)[1L]
  width <- as.integer(width)[1L]
  if (is.na(width) || width < 1L) {
    stop("`width` must be a positive integer", call. = FALSE)
  }

  cat("\n\n")

  core <- paste0(" ", label, " ")
  line <- if (nchar(core) >= width) {
    paste0("===", core, "===")
  } else {
    pad <- width - nchar(core)
    left <- pad %/% 2L
    paste0(strrep("=", left), core, strrep("=", pad - left))
  }

  cat(line, "\n", sep = "")
  invisible(label)
}
