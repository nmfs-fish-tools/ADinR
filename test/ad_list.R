library(Rcpp)
library(nloptr)
library(ADinR)

#load the adinr module
adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")

my.matrix <- matrix(data = "Rccp_variable", nrow = 3, ncol = 2)

my.matrix[1,1]<-adinr$variable()
