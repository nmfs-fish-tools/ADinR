library(Rcpp)
library(nloptr)
library(ADinR)

adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")


x<-c(-1.1,-0.5,0.1,0.7,1.3,1.9,2.5,3.1,3.7,4.3,4.9,5.5,6.1,
6.7,7.3,7.9,8.5,9.1,9.7,10.3,10.9,11.5,12.1,12.7,13.3,13.9,
14.5,15.1,15.7,16.3,16.9,17.5,18.1,18.7,19.3,19.9)

y<-c(5.29386, 6.26918, 5.13497, 4.94116, 14.0049, 24.4162,
33.3574, 45.9424, 52.523, 68.0024, 87.6086, 109.175, 135.83,
158.187, 185.461, 219.094, 251.922, 279.767, 316.908, 354.881,
402.207, 447.68, 492.535, 538.529, 588.272, 644.339, 694.982,
756.195, 806.676, 870.544, 940.154, 1005.47, 1066.03, 1143.94,
1208.17, 1282.73)

nobs<-length(x)

b0<-adinr$parameter()
b1<-adinr$parameter()
b2<-adinr$parameter()


norm2<-adinr$variable()

predicted <- c(1:length(x))
for(i in 1:nobs){
  pred_Y<- b0 + b1 * x[i] + b2 * (x[i] * x[i])
  norm2<-norm2 + pow(y[i]-pred_Y,2.0)
}

f<-(nobs/2.0) * log(norm2)




results<-adinr$minimize()

results
