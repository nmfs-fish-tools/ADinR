#Reference
#Fournier, D.A., H.J. Skaug, J. Ancheta, J. Ianelli,
#A. Magnusson, M.N. Maunder, A. Nielsen, and J. Sibert.
#2012. AD Model Builder: using automatic differentiation
#for statistical inference of highly parameterized complex
#nonlinear models. Optim. Methods Softw. 27:233-249.

library(Rcpp)
library(nloptr)
library(ADinR)

adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")

nobs<-10.0
x<-c(-1.0, 0.00,  1.0,  2.0,  3.0,  4.0,  5.0,  6.0,  7.0,  8.0)
y<-c(1.4,  4.7,  5.1,  8.3,  9.0,  14.5,  14.0,  13.4,  19.2,  18.0)

a<-adinr$parameter()
a$set_value(1.0)


b<-adinr$parameter()
b$set_value(2.1)

norm2<-adinr$variable()

predicted <- c(1:length(x)) 
for(i in 1:10){
  pred_Y<- a*x[i]+b
  predicted[[i]]<-pred_Y$value()
  print(predicted[[i]])
  norm2<-norm2 + pow(y[i]-pred_Y,2.0)
}

f<-(nobs/2.0) * log(norm2)




results<-adinr$minimize()

#startv<-c(a$value(), b$value())
#results<-nlminb(start=startv,objective=adinr$evaluate,gradient=adinr$gradient,control = list(abs.tol = 1e-6))
adinr$clear()

results
