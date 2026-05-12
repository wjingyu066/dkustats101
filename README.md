# dkustats101

This package provides lab templates, lecture activity templates, datasets, and helper functions for DKU STATS 101.

## Installation

Run the following code once:

``` r
install.packages("remotes")
remotes::install_github("wjingyu066/dkustats101")
```

## Load the package

``` r
library(dkustats101)
```

## Open a lab template

For example, to copy and open Lab 1.2:

``` r
use_lab("1.2")
```

This will ask you to choose a folder, then copy the Lab 1.2 Quarto file into that folder. If you are using RStudio, the file should open automatically.

## Open a lecture activity template

For example, to copy and open Lecture 3.4:

``` r
use_lecture("3.4")
```

## Important note

Before running `use_lab()` or `use_lecture()`, please make sure your working directory is the folder where you want to save your course files.
