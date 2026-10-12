# Getting Started with verbosity

## Overview

`verbosity` prints structured progress while a script runs:

- [`title()`](https://alon-alexander.github.io/verbosity/reference/title.md)
  — a centered section header
- [`section()`](https://alon-alexander.github.io/verbosity/reference/section.md)
  — a timed block whose printed output is indented
- [`log_time()`](https://alon-alexander.github.io/verbosity/reference/log_time.md)
  — elapsed time for an expression
- [`log_filter()`](https://alon-alexander.github.io/verbosity/reference/log_filter.md)
  — row, column, or length changes on a data frame or vector

## Example

[`title`](https://alon-alexander.github.io/verbosity/reference/title.md)`(``"Subset mtcars example"``)`` ``#> `` ``#> `` ``#> ============================ Subset mtcars example =============================`` `` `[`section`](https://alon-alexander.github.io/verbosity/reference/section.md)`(``"subset cars"``, ``{`` `` `[`log_time`](https://alon-alexander.github.io/verbosity/reference/log_time.md)`(``"load data"``, ``{`` `` ``cars`` ``<-`` ``mtcars`` `` ``}``)`` `` `` `[`log_filter`](https://alon-alexander.github.io/verbosity/reference/log_filter.md)`(``"mpg above 20"``, ``cars``, ``{`` `` ``cars`` ``<-`` ``cars``[``cars``$``mpg`` ``>`` ``20``, ``]`` `` ``}``)`` `` `` `[`head`](https://rdrr.io/r/utils/head.html)`(``cars``)`` ``}``)`` ``#> Start section subset cars`` ``#> [load data] start`` ``#> [load data] done in 0.00s`` ``#> Filter of "mpg above 20" finished and took 0.00s`` ``#> nrows: 32 -> 14`` ``#> mpg cyl disp hp drat wt qsec vs am gear carb`` ``#> Mazda RX4 21.0 6 160.0 110 3.90 2.620 16.46 0 1 4 4`` ``#> Mazda RX4 Wag 21.0 6 160.0 110 3.90 2.875 17.02 0 1 4 4`` ``#> Datsun 710 22.8 4 108.0 93 3.85 2.320 18.61 1 1 4 1`` ``#> Hornet 4 Drive 21.4 6 258.0 110 3.08 3.215 19.44 1 0 3 1`` ``#> Merc 240D 24.4 4 146.7 62 3.69 3.190 20.00 1 0 4 2`` ``#> Merc 230 22.8 4 140.8 95 3.92 3.150 22.90 1 0 4 2`` ``#> Section subset cars done in 0.00s`

Note:
[`log_filter()`](https://alon-alexander.github.io/verbosity/reference/log_filter.md)
compares the size of the given variable (before filter) and the result
of the expression (after filter).

## Using returned values

[`log_time()`](https://alon-alexander.github.io/verbosity/reference/log_time.md),
[`log_filter()`](https://alon-alexander.github.io/verbosity/reference/log_filter.md),
and
[`section()`](https://alon-alexander.github.io/verbosity/reference/section.md)
return the value of the expression. This can be used to store the result
in a variable:

`option1`` ``<-`` `[`log_time`](https://alon-alexander.github.io/verbosity/reference/log_time.md)`(``"load data"``, ``{`` `` ``mtcars`` ``}``)`` ``#> [load data] start`` ``#> [load data] done in 0.00s`` `` `[`log_time`](https://alon-alexander.github.io/verbosity/reference/log_time.md)`(``"load data"``, ``{`` `` ``option2`` ``<-`` ``mtcars`` ``}``)`` ``#> [load data] start`` ``#> [load data] done in 0.00s`` `` `[`identical`](https://rdrr.io/r/base/identical.html)`(``option1``, ``option2``)`` ``#> [1] TRUE`
