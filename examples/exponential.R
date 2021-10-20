library(Rcpp)
library(nloptr)
library(ADinR)

adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")


x<-c(0.1,0.7,1.3,1.9,2.5,3.1,3.7,4.3,4.9,5.5,
6.1,6.7,7.3,7.9,8.5,9.1,9.7,10.3,10.9,11.5,
12.1,12.7,13.3,13.9,14.5,15.1,15.7,16.3,16.9
,17.5,18.1,18.7,19.3,19.9)


y<-c(6.14013, 10.9014, 16.2082, 23.6577, 31.8638,
39.0495, 55.0857, 76.672, 88.3729, 106.488, 135.407,
161.65, 191.835, 216.537, 245.388, 280.615, 322.005,
356.254, 396.094, 448.594, 487.619, 532.935, 592.197,
644.919, 692.429, 756.265, 810.315, 873.324, 936.509,
997.534, 1070.68, 1144.18, 1212.92, 1284.21)

nobs<-length(x)

a<-adinr$parameter()
a$set_value(0.0)

k<-adinr$parameter()
k$set_value(0.0)

norm2<-adinr$variable()

predicted <- c(1:length(x))
for(i in 1:nobs){
  pred_Y<- a * exp(k * x[i])
  norm2<-norm2 + pow(y[i]-pred_Y,2.0)
}

f<-(nobs/2.0) * log(norm2)




results<-adinr$minimize()

results


