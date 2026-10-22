# dkustats101

This package provides course materials and helper functions for DKU STATS 101. Students can use this package to copy lab and activity folders to their own computer and work on the copied files directly.

## Installation

### Step 1: Install rstudioapi

Open RStudio and run the following code in the Console:

```         
install.packages("rstudioapi")
```

You only need to do this once.

### Step 2: Download the course package

Download the latest `dkustats101` `.tar.gz` file from Teams and save it to your computer.

**Do not unzip the file.**

### Step 3: Install the course package

In RStudio:

1.  Go to **Tools → Install Packages...**

2.  Under **Install from**, select **Package Archive File (.zip; .tar.gz)**.

3.  Click **Browse** and select the `.tar.gz` file you downloaded from Teams.

4.  Click **Install**.

Once installation is complete, run the following code in the Console:

```         
library(dkustats101)
```

## Updating the package

If the course materials have been updated, download the latest `.tar.gz` file from Teams.

First, restart R in RStudio by going to:

**Session → Restart R**

Then follow **Step 3** in the Installation section to install the updated package.

You do not need to reinstall `rstudioapi`.

Updating the package will not delete or change any files you have already copied to your computer.

## Load the package

Before using the course materials, load the package:

```         
library(dkustats101)
```

## Copy a lab folder

For example, to copy the folder for Lab 1.2:

```         
use_lab("1.2")
```

This will ask you to choose a folder on your computer. The full lab folder will be copied there, and the `.qmd` file should open automatically in RStudio.

## Copy an activity folder

For example, to copy the activity folder for Class 1.2:

```         
use_activity("1.2")
```

This will ask you to choose a folder on your computer. The full activity folder will be copied there, and the `.qmd` file should open automatically in RStudio.

If the activity includes images or other supporting files, those files will also be copied.

## Important notes

Please work on the copied files, not the files inside the package.

If a folder with the same name already exists, the package will stop to avoid accidentally replacing your work.

If you want to replace the existing folder, you can use:

```         
use_activity("1.2", overwrite = TRUE)
```

**Be careful:** `overwrite = TRUE` will replace the existing folder and its contents, including any changes you have made.

## Example workflow

A typical workflow is:

```         
library(dkustats101)

use_activity("1.2")
```

Then choose where to save the folder and start working on the copied `.qmd` file.

## Troubleshooting

### The package was updated, but I still see the old version

Restart R in RStudio using:

**Session → Restart R**

Then load the package again:

```         
library(dkustats101)
```

Remember that updating the package does not automatically update folders you copied previously. To get the latest materials, copy the folder again to a new location or use `overwrite = TRUE` if you no longer need your previous work.

### The package does not install

Make sure you downloaded the correct `.tar.gz` file from Teams and did not unzip it.

Try installing again using **Tools → Install Packages... → Package Archive File**.

If you receive an error message, please ask for help during class or office hours.

### The copied file does not open automatically

Make sure `rstudioapi` is installed:

```         
install.packages("rstudioapi")
```

Then try copying the course materials again.

If the `.qmd` file still does not open automatically, check the folder you selected. The copied files should still be there, and you can open the `.qmd` file manually in RStudio.
