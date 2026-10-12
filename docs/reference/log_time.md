# Log elapsed time of an expression

Evaluates `expr` in the calling environment, prints start and done
messages with elapsed seconds, and returns the result.

## Usage

``` r
log_time(label, expr)
```

## Arguments

- label:

  A character string identifying the timed block.

- expr:

  An expression to evaluate.

## Value

The result of `expr`.

## Examples

``` r
log_time("sleep", Sys.sleep(0.1))
#> [sleep] start
#> [sleep] done in 0.11s
```
