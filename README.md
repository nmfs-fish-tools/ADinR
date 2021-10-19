# ADinR - Automatic Differentiation in R

Automatic Differentiation in R (ADinR) uses a fast, static taped reverse-mode  AD modeling system for finding solutions to non-linear statistical modeling and optimization problems. 

# Getting started

## Installation instructions
Since this package contains C++ files, you will need to ensure you have a C++ compiler installed. You can install a C++ compiler [here](https://clang.llvm.org/), please make sure it is C++14 or more recent.

You will also need to have the `Rcpp` package installed. 

Please install and load `ADinR` from Github using the `remotes` package as follows:
```r
install.packages("remotes")
remotes::install_github("nmfs-fish-tools/ADinR")
library(r4MAS)
```

**Windows users**: Please ensure you have [Rtools](https://cran.r-project.org/bin/windows/Rtools/). If you receive errors related to C++ when loading ADinR, it could be because your R installation uses the default Makevars.win file. To update your Makevars.win file, please run the following code in your R terminal:

```r
dotR <- file.path(Sys.getenv("HOME"), ".R")
if (!file.exists(dotR)) 
  dir.create(dotR)
M <- file.path(dotR, "Makevars.win")
if (!file.exists(M)) 
  file.create(M)
cat("\nCXX14FLAGS=-O3 -Wno-unused-variable -Wno-unused-function",
    "CXX14 = $(BINPREF)g++ -m$(WIN) -std=c++1y",
    "CXX11FLAGS=-O3 -Wno-unused-variable -Wno-unused-function",
    file = M, sep = "\n", append = TRUE)
```
To get notifications about `ADinR`, you can watch this GitHub project.

## Disclaimer

“The United States Department of Commerce (DOC) GitHub project code is provided on an ‘as is’ basis and the user assumes responsibility for its use. DOC has relinquished control of the information and no longer has responsibility to protect the integrity, confidentiality, or availability of the information. Any claims against the Department of Commerce stemming from the use of its GitHub project will be governed by all applicable Federal law. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.”

- This project code is made available through GitHub but is managed by NOAA at
 https://vlab.ncep.noaa.gov/redmine/projects/integrated-fisheries-toolbox/files

<img src="https://raw.githubusercontent.com/nmfs-general-modeling-tools/nmfspalette/main/man/figures/noaa-fisheries-rgb-2line-horizontal-small.png" height="75" alt="NOAA Fisheries"> 

[U.S. Department of Commerce](https://www.commerce.gov/) | [National Oceanographic and Atmospheric Administration](https://www.noaa.gov) | [NOAA Fisheries](https://www.fisheries.noaa.gov/)
