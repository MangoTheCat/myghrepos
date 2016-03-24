
partial_regex <- "\\{\\{>\\s*([a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)?)\\s*\\}\\}"

extract_partials <- function(lines) {
  plines <- grep(partial_regex, lines, value = TRUE)

  pfilesplus <- gsub(
    paste0("^.*", partial_regex, ".*$"),
    "\\1 ",
    plines,
    perl = TRUE
  )

  drop_empty_strings(unlist(strsplit(pfilesplus, " ")))
}
