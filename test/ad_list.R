library(Rcpp)
library(nloptr)
library(ADinR)

#load the adinr module
adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")


make_nested_variable_list<-function(rows,cols){
    l<-list()
    for(i in 1:rows){
        r<-list()
        for(j in 1:cols){
            r[[j]]<-adinr$variable()
        }
        l[[i]]<-r
    }
    return(l)
}

make_variable_list<-function(size){
    l<-list()
    for(i in 1:size){
        r[[i]]<-adinr$variable()
    }
    return(l)
}


my.matrix <-make_nested_variable_list(10,10)

for(i in 1:10){
    for(j in 1:10){
        print(my.matrix[[i]][[j]]$value())
    }
}

my.matrix
