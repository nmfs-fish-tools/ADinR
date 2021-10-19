# ADinR - Automatic Differentiation in R

Automatic Differentiation in R (ADinR) uses a fast, staticly taped reverse-mode  AD modeling system for finding solutions to non-linear statistical modeling and optimization problems. 

# Getting started

## Installation instructions
Since this package contains C++ files, you will need to ensure you have a C++ compiler installed. You can install a C++ compiler [here](https://clang.llvm.org/), please make sure it is C++14 or more recent.

You will also need to have the `Rcpp` package installed. 

Please install and load `ADinR` from Github using the `remotes` package as follows:
```r
install.packages("remotes")
remotes::install_github("nmfs-fish-tools/ADinR")
library(ADinR)

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

## Example
```r
library(ADinR)

#load the adinr module
adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")

#Simple linear modeling example 

#some data
nobs<-10.0
x<-c(-1.0, 0.00,  1.0,  2.0,  3.0,  4.0,  5.0,  6.0,  7.0,  8.0)
y<-c(1.4,  4.7,  5.1,  8.3,  9.0,  14.5,  14.0,  13.4,  19.2,  18.0)

#estimated parameters
a<-adinr$parameter()
a$set_value(1.0)

b<-adinr$parameter()
b$set_value(2.1)

#declaring a variable
norm2<-adinr$variable()

for(i in 1:10){
  pred_y<- a*x[i]+b
  norm2<-norm2 + pow(y[i]-pred_y,2.0)
}

#likelihood
f<-(nobs/2.0) * log(norm2) 



#minimize the objective function
results<-adinr$minimize()

results

```
### Output:
```c
$converged
[1] TRUE

$iterations
[1] 10

$`runtime (seconds)`
[1] 6.8e-05

$`function value`
[1] 14.96419

$`max gradient component`
[1] 2.525271e-06

$gradient
[1] -1.045741e-06 -2.525271e-06

$`parameter values`
[1] 1.909091 4.078181
```
## Disclaimer

“The United States Department of Commerce (DOC) GitHub project code is provided on an ‘as is’ basis and the user assumes responsibility for its use. DOC has relinquished control of the information and no longer has responsibility to protect the integrity, confidentiality, or availability of the information. Any claims against the Department of Commerce stemming from the use of its GitHub project will be governed by all applicable Federal law. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.”

- This project code is made available through GitHub but is managed by NOAA at
 https://vlab.ncep.noaa.gov/redmine/projects/integrated-fisheries-toolbox/files

<img src="https://raw.githubusercontent.com/nmfs-general-modeling-tools/nmfspalette/main/man/figures/noaa-fisheries-rgb-2line-horizontal-small.png" height="75" alt="NOAA Fisheries"> 

[U.S. Department of Commerce](https://www.commerce.gov/) | [National Oceanographic and Atmospheric Administration](https://www.noaa.gov) | [NOAA Fisheries](https://www.fisheries.noaa.gov/)
