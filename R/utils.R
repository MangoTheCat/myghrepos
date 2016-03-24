
`%||%` <- function(l, r) if (is.null(l)) r else l

#' @importFrom utils packageName

myfile <- function(...) {
  system.file(..., package = packageName())
}

drop_empty_strings <- function(x) {
  x [ x != "" ]
}

as_string <- function(x) {
  x <- as.character(x)
  if (length(x) != 1 || is.na(x)) stop("Expected a string")
  x
}

pretty_date <- function(x) {
  format(as.Date(x))
}
