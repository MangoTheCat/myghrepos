
context("myghrepos")

test_that("get_repo_data", {

  skip_on_cran()

  data <- get_repo_data("MangoTheCat", groups = test_groups)

  expect_equal(length(data), 2)
  expect_equal(length(data[[1]]$contents), 1)
  expect_equal(length(data[[2]]$contents), 2)

  expect_equal(data[[1]]$name, test_groups[[1]]$name)
  expect_equal(data[[2]]$contents[[1]]$package, "rcmdcheck")
  expect_equal(data[[2]]$contents[[1]]$package, "cyclocomp")
})
