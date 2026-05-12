#' Copy a lab template to a selected folder
#'
#' @param id Lab ID, such as `"1.2"` or `"2.1"`.
#' @param destdir Destination directory. If `NULL`, students will be asked to choose a folder in RStudio.
#' @param overwrite If `TRUE`, overwrite an existing file with the same name.
#' @param open If `TRUE`, try to open the copied file in RStudio.
#'
#' @return Invisibly returns the path to the copied file.
#' @export
use_lab <- function(id, destdir = NULL, overwrite = FALSE, open = TRUE) {
  copy_qmd_template(
    id = id,
    type = "lab",
    destdir = destdir,
    overwrite = overwrite,
    open = open
  )
}


#' Copy a lecture activity template to a selected folder
#'
#' @param id Lecture ID, such as `"3.4"` or `"4.1"`.
#' @param destdir Destination directory. If `NULL`, students will be asked to choose a folder in RStudio.
#' @param overwrite If `TRUE`, overwrite an existing file with the same name.
#' @param open If `TRUE`, try to open the copied file in RStudio.
#'
#' @return Invisibly returns the path to the copied file.
#' @export
use_lecture <- function(id, destdir = NULL, overwrite = FALSE, open = TRUE) {
  copy_qmd_template(
    id = id,
    type = "lecture",
    destdir = destdir,
    overwrite = overwrite,
    open = open
  )
}


copy_qmd_template <- function(id, type, destdir = NULL, overwrite = FALSE, open = TRUE) {
  if (!type %in% c("lab", "lecture")) {
    stop("`type` must be either 'lab' or 'lecture'.", call. = FALSE)
  }

  # If no destination folder is given, ask the user to choose one in RStudio.
  # If RStudio is not available, fall back to the current working directory.
  if (is.null(destdir)) {
    if (requireNamespace("rstudioapi", quietly = TRUE) &&
        rstudioapi::isAvailable()) {
      destdir <- rstudioapi::selectDirectory(
        caption = "Choose where to save this course file"
      )

      # If the student cancels the folder selection window
      if (is.null(destdir) || identical(destdir, "")) {
        stop("No folder was selected. Please run the function again and choose a folder.", call. = FALSE)
      }
    } else {
      destdir <- getwd()
      message("RStudio folder selection is not available. Using current working directory: ", destdir)
    }
  }

  if (!dir.exists(destdir)) {
    stop("The destination directory does not exist: ", destdir, call. = FALSE)
  }

  subdir <- if (type == "lab") "labs" else "lectures"
  prefix <- if (type == "lab") "lab" else "lecture"

  filename <- paste0(prefix, "-", id, ".qmd")

  source_file <- system.file(
    "qmd",
    subdir,
    filename,
    package = "dkustats101",
    mustWork = TRUE
  )

  destination_file <- file.path(destdir, filename)

  if (file.exists(destination_file) && !overwrite) {
    stop(
      "The file already exists: ", destination_file, "\n",
      "Use overwrite = TRUE if you want to replace it.",
      call. = FALSE
    )
  }

  copied <- file.copy(
    from = source_file,
    to = destination_file,
    overwrite = overwrite
  )

  if (!copied) {
    stop("Could not copy the template file.", call. = FALSE)
  }

  # If RStudio is available, automatically open the copied file.
  if (isTRUE(open) &&
      requireNamespace("rstudioapi", quietly = TRUE) &&
      rstudioapi::isAvailable()) {
    rstudioapi::navigateToFile(destination_file)
  }

  message("Copied template to: ", normalizePath(destination_file, mustWork = FALSE))

  invisible(normalizePath(destination_file, mustWork = FALSE))
}
