library(Rcpp)
library(nloptr)
library(ADinR)

#load the adinr module
adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")

my.matrix <-adinr$matrix(10,10)

for(i in 1:10){
    for(j in 1:10){
        print(my.matrix$at(i,j)$value())
    }
}
