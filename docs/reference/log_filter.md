# Log size changes of a variable during an expression

Evaluates `expr` in the calling environment, checks that `variable` is a
data frame or has length greater than one, verifies that the expression
result stays a data frame (or non-data frame), and logs row, column, or
length changes.

## Usage

``` r
log_filter(label, variable, expr)
```

## Arguments

- label:

  A character string identifying the filtered block.

- variable:

  A data frame or vector with length greater than one.

- expr:

  An expression to evaluate (typically modifying `variable`).

## Value

The result of `expr`.

## Examples

``` r
df <- data.frame(x = 1:5, y = 6:10)
log_filter("subset rows", df, df <- df[1:3, ])
#> Filter of "subset rows" finished and took 0.00s
#>     nrows: 5 -> 3
```
