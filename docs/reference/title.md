# Print a centered section title

Prints two blank lines, then `label` centered in a row of `"="`
characters.

## Usage

``` r
title(label, width = cli::console_width())
```

## Arguments

- label:

  A character string to display.

- width:

  Total width of the title row. Defaults to
  [`cli::console_width()`](https://cli.r-lib.org/reference/console_width.html).

## Value

Invisibly returns `label`.

## Examples

``` r
title("Section")
#> 
#> 
#> =================================== Section ====================================
title("Section", width = 40)
#> 
#> 
#> =============== Section ================
```
