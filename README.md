# dkustats101

This package provides course material templates and helper functions for DKU STATS 101.

Students can use this package to copy lab folders, lecture folders, and activity folders to their own computer, then work on the copied files directly.

## Installation

Run the following code once:

``` r
install.packages("remotes")
install.packages("rstudioapi")
remotes::install_github("wjingyu066/dkustats101")
```

## Updating the package

If the course materials have been updated, reinstall the package with:

``` r
remotes::install_github("wjingyu066/dkustats101", force = TRUE)
```

This updates the package only. It will not delete or change any files you have already copied to your own computer.

## Load the package

Before using the course materials, load the package:

``` r
library(dkustats101)
```

## Copy a lab folder

For example, to copy the folder for Lab 1.2:

``` r
use_lab("1.2")
```

This will ask you to choose a folder on your computer. The full lab folder will be copied there.

If you are using RStudio, the `.qmd` file should open automatically after copying.

## Copy a lecture folder

For example, to copy the folder for Lecture 3.4:

``` r
use_lecture("3.4")
```

This will ask you to choose a folder on your computer. The full lecture folder will be copied there.

## Copy an activity folder

For example, to copy the activity folder for Lecture 1.2:

``` r
use_activity("1.2")
```

This will ask you to choose a folder on your computer. The full activity folder will be copied there.

If the activity uses images or other supporting files, those files will be copied together with the `.qmd` file.

## Important notes

Please work on the copied files, not the files inside the package.

When you run a command such as:

``` r
use_activity("1.2")
```

you will choose where to save the folder. After that, edit the copied `.qmd` file in that folder.

If you already have a folder with the same name, R will stop to avoid accidentally replacing your work. If you really want to replace the existing folder, you can use:

``` r
use_activity("1.2", overwrite = TRUE)
```

Use `overwrite = TRUE` carefully, because it will replace the existing copied folder.

## Example workflow

A typical workflow is:

``` r
library(dkustats101)

use_activity("1.2")
```

Then choose where to save the folder, open the copied `.qmd` file, and start working.

## Troubleshooting

If installation from GitHub does not work, first check that you typed the repository name correctly:

``` r
remotes::install_github("wjingyu066/dkustats101")
```

If you are using RStudio and the file does not open automatically, check the folder you selected. The copied course folder should still be there.

If GitHub installation is slow or fails because of network issues, please try again later or ask for help during class or office hours.
