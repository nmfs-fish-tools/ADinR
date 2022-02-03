remotes::install_github("nmfs-fish-tools/ADinR")

library(Rcpp)
library(nloptr)
library(ADinR)

#load the adinr module
adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")

u_values<-c(4.0, 2.0, 1.0, 5.0e-1, 2.5e-1, 1.67e-1, 1.25e-1, 1.0e-1,
8.33e-2, 7.14e-2, 6.25e-2)

u<-vector(mode = "list", length = length(u_values))

for(i in 1:length(u)){
    u[[i]]<-adinr$variable()
    u[[i]]$set_value(u_values[i])
}

y<-c(1.957e-1, 1.947e-1, 1.735e-1, 1.6e-1, 8.44e-2, 6.27e-2,
4.56e-2, 3.42e-2, 3.23e-2, 2.35e-2, 2.46e-2)

init_values <- c(2.5, 3.9, 4.15, 3.9)

nobs<-length(y)

#estimated independent variables
x0<-adinr$parameter()
x0$set_value(2.5)
x0$bounds(0,100)

x1<-adinr$parameter()
x1$set_value(3.9)
x1$bounds(0,100)

x2<-adinr$parameter()
x2$set_value(4.15)
x2$bounds(0,100)

x3<-adinr$parameter()
x3$set_value(3.9)
x3$bounds(0,100)

adinr$set_recording(TRUE)

#least squares objective function
norm2<-adinr$variable()

for(i in 1:nobs){
  pred_Y<- x0 * (pow(u[[i]],2) + x1 * u[[i]]) / (pow(u[[i]],2) + x2* u[[i]] + x3)
  norm2<-norm2 + pow(y[i]-pred_Y,2.0)
}

f<-norm2

control<-list()
control["max_iterations"]<-3000
#minimize the objective function
results<-adinr$minimize(control)

predicted <- c(1:nobs)

for(i in 1:nobs){
  pred_Y<-x0 * (pow(u[[i]],2) + x1 * u[[i]]) / (pow(u[[i]],2) + x2* u[[i]] + x3)
  predicted[i]<-pred_Y$value()
}

plot.new()
plot(x=u_values, y=y)
lines(u_values,predicted)

print(results)
