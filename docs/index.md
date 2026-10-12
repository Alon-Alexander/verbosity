# verbosity

Utilities for logging and verbosity in R.

------------------------------------------------------------------------

[![R-CMD-check](https://github.com/Alon-Alexander/verbosity/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Alon-Alexander/verbosity/actions/workflows/R-CMD-check.yaml)

Print titles, section wrappers, time expressions, and log how a data
frame (or vector) changes size. See the [Getting Started
vignette](https://alon-alexander.github.io/verbosity/articles/getting-started.html).

## Installation

This package is not on CRAN, so install it from GitHub:

[`library`](https://rdrr.io/r/base/library.html)`(`[`devtools`](https://devtools.r-lib.org/)`)`` ``devtools``::`[`install_github`](https://remotes.r-lib.org/reference/install_github.html)`(``"Alon-Alexander/verbosity"``)`

## Usage

[`library`](https://rdrr.io/r/base/library.html)`(`[`verbosity`](https://alon-alexander.github.io/verbosity/)`)`` `` `[`title`](https://alon-alexander.github.io/verbosity/reference/title.md)`(``"Showcase verbosity package"``)`` `` `[`section`](https://alon-alexander.github.io/verbosity/reference/section.md)`(``"load and filter"``, ``{`` `` `[`log_time`](https://alon-alexander.github.io/verbosity/reference/log_time.md)`(``"load data"``, ``{`` `` ``df`` ``<-`` `[`as.data.frame`](https://rdrr.io/r/base/as.data.frame.html)`(`[`matrix`](https://rdrr.io/r/base/matrix.html)`(`[`rnorm`](https://rdrr.io/r/stats/Normal.html)`(``1000`` ``*`` ``200``)``, nrow ``=`` ``1000``, ncol ``=`` ``200``)``)`` `` ``}``)`` `` `` `[`log_filter`](https://alon-alexander.github.io/verbosity/reference/log_filter.md)`(``"good values"``, ``df``, ``{`` `` ``df`` ``<-`` ``df``[`[`rowSums`](https://rdrr.io/r/base/colSums.html)`(``df``)`` ``>`` ``0``]`` `` ``}``)`` ``}``)`

Expected output is something like:

```
====== Showcase verbosity package ======

Start section load and filter
    [load data] start
    [load data] done in 0.01s
    Filter of "good values" finished and took 0.02s
        nrows: 1000 -> 504
Section load and filter done in 0.03s
```

Note: The actual timing (e.g., `0.01s`) and resulting number of rows
(`X`) will depend on your machine and the random data. You should see
similar logged structure and messages.
