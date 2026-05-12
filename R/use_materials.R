#' Copy a lab template into the current working directory
#'
#' @param id Lab ID, such as `"1.2"` or `"2.1"`.
#' @param destdir Destination directory. Defaults to the current working directory.
#' @param overwrite If `TRUE`, overwrite an existing file with the same name.
#' @param open If `TRUE`, try to open the file in RStudio.
#'
#' @return Invisibly returns the path to the copied file.
#' @export
use_lab <- function(id, destdir = getwd(), overwrite = FALSE, open = TRUE) {
  copy_qmd_template(
    id = id,
    type = "lab",
    destdir = destdir,
    overwrite = overwrite,
    open = open
  )
}

#' Copy a lecture template into the current working directory
#'
#' @param id Lecture ID, such as `"3.4"` or `"4.1"`.
#' @param destdir Destination directory. Defaults to the current working directory.
#' @param overwrite If `TRUE`, overwrite an existing file with the same name.
#' @param open If `TRUE`, try to open the file in RStudio.
#'
#' @return Invisibly returns the path to the copied file.
#' @export
use_lecture <- function(id, destdir = getwd(), overwrite = FALSE, open = TRUE) {
  copy_qmd_template(
    id = id,
    type = "lecture",
    destdir = destdir,
    overwrite = overwrite,
    open = open
  )
}

copy_qmd_template <- function(id, type, destdir, overwrite, open) {
  if (!dir.exists(destdir)) {
    stop("The destination directory does not exist: ", destdir, call. = FALSE)
  }

  if (!type %in% c("lab", "lecture")) {
    stop("`type` must be either 'lab' or 'lecture'.", call. = FALSE)
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

  if (isTRUE(open) &&
      requireNamespace("rstudioapi", quietly = TRUE) &&
      rstudioapi::isAvailable()) {
    rstudioapi::navigateToFile(destination_file)
  }

  message("Copied template to: ", normalizePath(destination_file, mustWork = FALSE))

  invisible(normalizePath(destination_file, mustWork = FALSE))
}
