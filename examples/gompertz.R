library(Rcpp)
library(nloptr)
library(ADinR)

#load the adinr module
adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")

#data
x<-c(0.1,0.7,1.3,1.9,2.5,3.1,3.7,4.3,4.9,5.5,
6.1,6.7,7.3,7.9,8.5,9.1,9.7,10.3,10.9,11.5,
12.1,12.7,13.3,13.9,14.5,15.1,15.7,16.3,16.9,
17.5,18.1,18.7,19.3,19.9)


y<-c(0.442393, -0.325115, 0.462054, -0.246129,
0.330028, -0.403752, 0.420049, -0.231133, -0.157497,
-0.0130334, -0.0586079, -0.435467, -0.516173,
-0.779948, -0.102388, -0.0386633, -0.644148,
-0.821973, -0.798648, -0.155259, -0.896364,
-0.819737, -0.739377, -0.0404252, -0.84172,
-0.550121, -0.564661, -0.194486, -0.770216,
-0.819412, -0.114417, -0.130755, -0.512492,
-0.557175)

nobs<-length(x)

#independent parameters
a<-adinr$parameter()
a$set_value(1.0)

b<-adinr$parameter()
b$set_value(1.0)

c<-adinr$parameter()
c$set_value(1.0)



#objective function
norm2<-adinr$variable()

predicted <- c(1:length(x))
for(i in 1:nobs){
  pred_Y<- a*exp(-1.0*exp(b-c*x[i]))
  norm2<-norm2 + pow(y[i]-pred_Y,2.0)
}

f<-(nobs/2.0) * log(norm2)



#minimize the objective function
results<-adinr$minimize()

results

