# Run a block of code with nice output wrapping.

Evaluates each statement in `code_block` in the calling environment.
Printed output from the block is captured and re-emitted indented.
Prints start and done messages with elapsed seconds, and returns the
result of the last statement.

## Usage

``` r
section(label, code_block)
```

## Arguments

- label:

  A character string identifying the section.

- code_block:

  An expression or `{ ... }` block to evaluate.

## Value

The result of the last expression in `code_block`.

## Examples

``` r
section("greet", {
  cat("hello\n")
  cat("world\n")
})
#> Start section greet
#>     hello
#>     world
#> Section greet done in 0.00s
section("preview", head(mtcars, 2))
#> Start section preview
#>                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
#>     Mazda RX4      21   6  160 110  3.9 2.620 16.46  0  1    4    4
#>     Mazda RX4 Wag  21   6  160 110  3.9 2.875 17.02  0  1    4    4
#> Section preview done in 0.01s
```
