
#' Create a Web Page About Your GitHub Repositories
#'
#' This is a static website generator, specialized on creating a single
#' page web site about GitHub repositories, for an account or organization.
#'
#' @param org GitHub organization or user name.
#' @param target Target directory for the generated file(s).
#' @param groups Repo groups, see \code{\link{repo_group}}.
#' @param data The repo data, if you already have it, as
#'   returned by \code{\link{get_repo_data}}.
#'
#' @export
#' @importFrom stats setNames

myghrepos <- function(org, target = tempfile(), groups = NULL, data = NULL) {

  org <- as_string(org)
  target <- as_string(target)

  if (!dir.exists(target)) dir.create(target)

  repo_data <- data %||% get_repo_data(org, groups)

  lines <- readLines(myfile("template/index.html"))
  partials <- extract_partials(lines)
  partial_files <- myfile("template", partials)
  if (length(partial_files) < length(partials)) {
    stop("Some partials not found")
  }

  plines <- setNames(lapply(partial_files, readLines), partials)
  wlines <- lapply(
    plines,
    safe_whisker,
    data = list(groups = repo_data, org = org)
  )

  write_results(
    safe_whisker(lines, partials = wlines),
    target
  )
}


write_results <- function(page, target) {
  output_file <- file.path(target, "index.html")
  message("Writing ", output_file, " ... ", appendLF = FALSE)
  writeLines(page, con = output_file)
  message("done.")
}

#' Workaround for whisker mishandling corner cases
#'
#' @param template Template.
#' @param ... Extra arguments to \code{whisker.render}.
#'
#' @importFrom whisker whisker.render
#' @importFrom utils tail
#' @keywords internal

safe_whisker <- function(template, ...) {
  first_non_empty <- which(template != "")

  template <- if (!length(template)) {
    ""

  } else if (!length(first_non_empty)) {
    paste(rep("\n", length(template)), collapse = "")

  } else if (first_non_empty[1] != 1) {
    c(
      paste(rep("\n", first_non_empty[1] - 1), collapse = ""),
      tail(template, -(first_non_empty[1] - 1))
    )

  } else {
    template
  }

  whisker.render(template, ...)
}
