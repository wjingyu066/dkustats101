#' Copy a lab folder to a selected folder
#'
#' @param id Lab ID, such as `"1.2"` or `"2.1"`.
#' @param destdir Destination directory. If `NULL`, students will be asked to choose a folder in RStudio.
#' @param overwrite If `TRUE`, overwrite an existing folder with the same name.
#' @param open If `TRUE`, try to open the copied `.qmd` file in RStudio.
#'
#' @return Invisibly returns the path to the copied folder.
#' @export
use_lab <- function(id, destdir = NULL, overwrite = FALSE, open = TRUE) {
  copy_material_folder(
    id = id,
    type = "lab",
    destdir = destdir,
    overwrite = overwrite,
    open = open
  )
}


#' Copy a lecture folder to a selected folder
#'
#' @param id Lecture ID, such as `"3.4"` or `"4.1"`.
#' @param destdir Destination directory. If `NULL`, students will be asked to choose a folder in RStudio.
#' @param overwrite If `TRUE`, overwrite an existing folder with the same name.
#' @param open If `TRUE`, try to open the copied `.qmd` file in RStudio.
#'
#' @return Invisibly returns the path to the copied folder.
#' @export
use_lecture <- function(id, destdir = NULL, overwrite = FALSE, open = TRUE) {
  copy_material_folder(
    id = id,
    type = "lecture",
    destdir = destdir,
    overwrite = overwrite,
    open = open
  )
}


#' Copy an activity folder to a selected folder
#'
#' @param id Activity ID, such as `"1.2"` or `"3.4"`.
#' @param destdir Destination directory. If `NULL`, students will be asked to choose a folder in RStudio.
#' @param overwrite If `TRUE`, overwrite an existing folder with the same name.
#' @param open If `TRUE`, try to open the copied `.qmd` file in RStudio.
#'
#' @return Invisibly returns the path to the copied folder.
#' @export
use_activity <- function(id, destdir = NULL, overwrite = FALSE, open = TRUE) {
  copy_material_folder(
    id = id,
    type = "activity",
    destdir = destdir,
    overwrite = overwrite,
    open = open
  )
}


copy_material_folder <- function(id, type, destdir = NULL, overwrite = FALSE, open = TRUE) {
  if (!type %in% c("lab", "lecture", "activity")) {
    stop("`type` must be 'lab', 'lecture', or 'activity'.", call. = FALSE)
  }

  if (is.null(destdir)) {
    destdir <- choose_destination_folder()
  }

  if (!dir.exists(destdir)) {
    stop("The destination directory does not exist: ", destdir, call. = FALSE)
  }

  subdir <- switch(
    type,
    lab = "labs",
    lecture = "lectures",
    activity = "activities"
  )

  folder_name <- switch(
    type,
    lab = paste0("Lab ", id),
    lecture = paste0("Lecture ", id),
    activity = paste0("Lecture ", id)
  )

  source_folder <- system.file(
    "materials",
    subdir,
    folder_name,
    package = "dkustats101",
    mustWork = TRUE
  )

  destination_folder <- file.path(destdir, folder_name)

  if (dir.exists(destination_folder) && !overwrite) {
    stop(
      "The folder already exists: ", destination_folder, "\n",
      "Use overwrite = TRUE if you want to replace it.",
      call. = FALSE
    )
  }

  if (dir.exists(destination_folder) && overwrite) {
    unlink(destination_folder, recursive = TRUE, force = TRUE)
  }

  copy_directory(source_folder, destination_folder)

  qmd_files <- list.files(
    destination_folder,
    pattern = "\\.qmd$",
    full.names = TRUE,
    recursive = TRUE
  )

  if (length(qmd_files) > 0 && isTRUE(open)) {
    qmd_to_open <- qmd_files[1]

    if (requireNamespace("rstudioapi", quietly = TRUE) &&
        rstudioapi::isAvailable()) {
      rstudioapi::navigateToFile(qmd_to_open)
    }
  }

  message("Copied material folder to: ", normalizePath(destination_folder, mustWork = FALSE))

  invisible(normalizePath(destination_folder, mustWork = FALSE))
}


choose_destination_folder <- function() {
  if (requireNamespace("rstudioapi", quietly = TRUE) &&
      rstudioapi::isAvailable()) {
    destdir <- rstudioapi::selectDirectory(
      caption = "Choose where to save this course folder"
    )

    if (is.null(destdir) || identical(destdir, "")) {
      stop("No folder was selected. Please run the function again and choose a folder.", call. = FALSE)
    }

    return(destdir)
  }

  destdir <- getwd()
  message("RStudio folder selection is not available. Using current working directory: ", destdir)
  destdir
}


copy_directory <- function(source_folder, destination_folder) {
  if (!dir.exists(source_folder)) {
    stop("Source folder does not exist: ", source_folder, call. = FALSE)
  }

  dir.create(destination_folder, recursive = TRUE, showWarnings = FALSE)

  all_files <- list.files(
    source_folder,
    all.files = TRUE,
    no.. = TRUE,
    recursive = TRUE,
    full.names = TRUE
  )

  if (length(all_files) == 0) {
    return(invisible(destination_folder))
  }

  relative_paths <- substring(all_files, nchar(source_folder) + 2)
  destination_paths <- file.path(destination_folder, relative_paths)

  dirs_to_create <- unique(dirname(destination_paths))
  dir.create(dirs_to_create, recursive = TRUE, showWarnings = FALSE)

  file_info <- file.info(all_files)
  files_only <- all_files[!file_info$isdir]
  destination_files_only <- destination_paths[!file_info$isdir]

  copied <- file.copy(
    from = files_only,
    to = destination_files_only,
    overwrite = TRUE
  )

  if (any(!copied)) {
    stop("Some files could not be copied.", call. = FALSE)
  }

  invisible(destination_folder)
}
