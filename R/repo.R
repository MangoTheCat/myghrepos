
#' Get repository data for the specified organization and repo groups
#'
#' @param org Organization name.
#' @inheritParams myghrepos
#' 
#' @importFrom gh gh

get_repo_data <- function(org, groups) {
  data <- lapply(groups, function(group) {
    list(
      name = group$name,
      contents = lapply(group$repos, function(x) {
        message("Getting repo ", x)
        list(
          package = x,
          contents = gh("/repos/:owner/:repo", owner = org, repo = x),
          "description-file" = get_desc_desc(org, x)
        )
      })
    )
  })

  preprocess_repo_data(data)
}

#' Define a group of repositories
#'
#' @param name Group name.
#' @param description Group description.
#' @param repos Character vector, repositories to include in the group.
#' @return Repo group object.
#'
#' @export

repo_group <- function(name, description = NULL, repos) {
  structure(
    list(
      name = name,
      description = description,
      repos = repos
    ),
    class = "repo_group"
  )
}

#' @importFrom httr GET status_code content
#' @importFrom desc description

get_desc_desc <- function(org, repo) {
  url <- sprintf(
    "https://raw.githubusercontent.com/%s/%s/master/DESCRIPTION",
    org,
    repo
  )
  response <- GET(url)
  if (status_code(response) >= 300) {
    message("No description, not an R package?", appendLF = FALSE)
    return(NULL)
  }

  tmp <- tempfile()
  on.exit(unlink(tmp), add = TRUE)
  cat(content(response), file = tmp)

  description $ new(tmp) $ get("Description")
}

preprocess_repo_data <- function(data) {
  for (group in seq_along(data)) {
    for (repo in seq_along(data[[group]]$contents)) {
      date <- data[[group]]$contents[[repo]]$contents$pushed_at
      data[[group]]$contents[[repo]]$contents$pushed_at <- pretty_date(date)
    }
  }

  data
}
