# verbosity

Utilities for logging and verbosity in R.

---

[![R-CMD-check](https://github.com/Alon-Alexander/verbosity/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Alon-Alexander/verbosity/actions/workflows/R-CMD-check.yaml)

Print titles, section wrappers, time expressions, and log how a data frame (or vector) changes size. See the [Getting Started vignette](https://alon-alexander.github.io/verbosity/articles/getting-started.html).

## Installation

This package is not on CRAN, so install it from GitHub:

```r
library(devtools)
devtools::install_github("Alon-Alexander/verbosity")
```

## Usage

```r
library(verbosity)

title("Showcase verbosity package")

section("load and filter", {
    log_time("load data", {
        df <- as.data.frame(matrix(rnorm(1000 * 200), nrow = 1000, ncol = 200))
    })

    cat("Just printing some stuff...\n")

    log_filter("good values", df, {
        df <- df[rowSums(df) > 0]
    })
})
```

Expected output is something like:
```text
====== Showcase verbosity package ======

Start section load and filter
    [load data] start
    [load data] done in 0.01s
    Just printing some stuff...
    Filter of "good values" finished and took 0.02s
        nrows: 1000 -> 504
Section load and filter done in 0.03s
```

Note: The actual timing (e.g., `0.01s`) and resulting number of rows (`X`) will depend on your machine and the random data. You should see similar logged structure and messages.

