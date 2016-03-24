
mango_repos <- function() {

  list(
    ## Some time in the future. :)
    ##    repo_group(
    ##       name = "Featured R Packages",
    ##       repos = c()
    ##    ),

    repo_group(
      name = "Packages for R Training",
      repos = c("mangoTraining")
    ),

    repo_group(
      name = "Tools for R package development",
      repos = c("rcmdcheck", "cyclocomp")
    ),

    repo_group(
      name = "Other Tools and Gadgets",
      repos = c("SASxport", "BLCOP", "pkgsnap", "rmdshower", "simplegraph",
        "radarchart", "remotes", "tidyshiny", "slideBreakR", "franc",
        "showimage", "sankey", "swli")
    ),

    repo_group(
      name = "Work in Progress",
      repos = c("goodpractice", "RNMImport", "RNMGraphics", "visualTest",
                "functionMap", "keyring", "autoPricing")
    )
  )
}
