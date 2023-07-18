
Sys.setenv(R_TESTS = "")
#remotes::install_github("nmfs-fish-tools/ADinR")
library(testthat)
library(methods)
library(Rcpp)
library(ADinR)
#load the adinr module
# adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")

test_check("ADinR")
