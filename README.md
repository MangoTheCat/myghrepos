
# myghrepos

> Create a Nice Web Page About Your GitHub Repositories

This is a static website generator, specialized on creating a single page web
  site about GitHub repositories, for an account or organization.

## Installation

```r
devtools::install_github("mangothecat/myghrepos")
```

## Usage

```r
library(myghrepos)
myghrepos("MangoTheCat", target = "/tmp", groups = list(repo_group(), ...))
```

## License

MIT © Mango Solutions
