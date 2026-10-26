
# dkustats101

This package provides course materials and helper functions for DKU STATS 101. Students can use this package to copy lab and activity folders to their own computer and work on the copied files directly.

## Installation

Open RStudio and run the following code in the Console:

```r
install.packages("remotes")
install.packages("rstudioapi")
remotes::install_github("wjingyu066/dkustats101", upgrade = "never")
```

You only need to install `remotes` and `rstudioapi` once.

Once installation is complete, load the package:

```r
library(dkustats101)
```

## Updating the package

If the course materials have been updated, run the following code in the Console:

```r
remotes::install_github("wjingyu066/dkustats101", force = TRUE, upgrade = "never")
```

After updating, restart R in RStudio by going to:

**Session → Restart R**

Then load the package again:

```r
library(dkustats101)
```

Updating the package will not delete or change any files you have already copied to your computer.

## Load the package

Before using the course materials, load the package:

```r
library(dkustats101)
```

## Copy a lab folder

For example, to copy the folder for Lab 1.2:

```r
use_lab("1.2")
```

This will ask you to choose a folder on your computer. The full lab folder will be copied there, and the `.qmd` file should open automatically in RStudio.

## Copy an activity folder

For example, to copy the activity folder for Lecture 1.2:

```r
use_activity("1.2")
```

This will ask you to choose a folder on your computer. The full activity folder will be copied there, and the `.qmd` file should open automatically in RStudio.

If the activity includes images or other supporting files, those files will also be copied.

## Important notes

Please work on the copied files, not the files inside the package.

If a folder with the same name already exists, the package will stop to avoid accidentally replacing your work.

If you want to replace the existing folder, you can use:

```r
use_activity("1.2", overwrite = TRUE)
```

**Be careful:** `overwrite = TRUE` will replace the existing folder and its contents, including any changes you have made.

## Example workflow

A typical workflow is:

```r
library(dkustats101)

use_activity("1.2")
```

Then choose where to save the folder and start working on the copied `.qmd` file.

## Troubleshooting

### The package was updated, but I still see the old version

Restart R in RStudio using:

**Session → Restart R**

Then load the package again:

```r
library(dkustats101)
```

Remember that updating the package does not automatically update folders you copied previously. To get the latest materials, copy the folder again to a new location or use `overwrite = TRUE` if you no longer need your previous work.

### Installation from GitHub does not work

Make sure you are connected to the internet and try the installation command again:

```r
remotes::install_github("wjingyu066/dkustats101", upgrade = "never")
```

If the installation is slow or fails because of network issues, please ask for help during class or office hours.

### The copied file does not open automatically

Make sure you are running the code in RStudio and that `rstudioapi` is installed:

```r
install.packages("rstudioapi")
```

If the `.qmd` file still does not open automatically, check the folder you selected. The copied files should still be there, and you can open the `.qmd` file manually in RStudio.

