remotes::install_github("nmfs-fish-tools/ADinR")

library(Rcpp)
library(nloptr)
library(ADinR)



#load the adinr module
adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")

ad_matrix<-function(nrow, ncol){
  slots <- matrix(list(), ncol, nrow)
  for(i in 1:nrow){
    for(j in 1:ncol){
      slots[[i,j]]<-adinr$variable()
    }
  }
  return(slots)
}
m<-ad_matrix(5,5)
n<-ad_matrix(5,5)
p<-m*n
print(m[[1,1]]$value())

#helper function
make_variable_list<-function(length){
  l<-list()
  for(i in 1:length){
    l[[i]]<-adinr$variable()
  }
  return(l)
}

time<-c(40,43,46,49,52,55,58,61,64,67,70,73,76,79,82,85,88,
        91,94,97,100,103,106,109,112,115,118,121,124,127,
        130,133,136,139,142,145,148,151,154,157,160,163,166,
        169,172)

nobs<-length(time)

observedCPUE<-c(2.33,1.97,1.8,1.76,1.69,1.63,1.51,1.47,1.4,
                1.48,1.47,1.5,1.49,1.33,1.49,1.54,1.5,1.6,
                1.67,1.79,1.75,1.94,2.13,2.3,2.32,2.36,2.29,
                2.35,1.53,1.19,1.12,1.11,0.96,0.9,0.81,0.72,
                0.7,0.52,0.3,0.33,0.19,0.18,0.13,0.14,0.06)
observedCPUE<-observedCPUE*runif(n = nobs, min = 0.9, max = 1.1)

observedEffort<-c(2.58,2.49,2.06,2.5,2.43,2.15,2.32,2.59,2.36,
                  2.23,1.9,2,2.62,1.05,1.41,1.23,1.33,1.06,0.9,
                  1.06,0.97,0.62,0.94,0.87,1.12,1.23,1.31,4.77,
                  4.58,4.37,5.09,5.05,4.38,4.78,4.32,5.42,5,6.54,
                  7,7.27,6.32,6.67,6.92,7.14,3.33)
observedEffort<-observedEffort*runif(n = nobs, min = 0.9, max = 1.1)

#PARAMETERS
r<-adinr$parameter()
r$set_value(0.5)

q<-adinr$parameter()
q$set_value(0.5)

k<-adinr$parameter()
k$set_value(0.5)

predictedCPUE<-make_variable_list(nobs)

#OBJECTIVE FUNCTION
adinr$set_recording(TRUE)



# shaeffer<-function(){
#   
#   for ( i in 1:nobs) {
#     predictedCPUE[[i]]<<- r -
#       (r / q * k) *
#       observedCPUE[i] -
#       q * observedEffort[i];
#   }
#   
# }
# 
# schnutte<-function(){
#   
#   for ( i in 1:(nobs-1) ) {
#     predictedCPUE[[i]]<<- r -
#       (r / q * k) *
#       ((observedCPUE[i] + observedCPUE[i + 1]) / 2.0) -
#       q * ((observedEffort[i] + observedEffort[i]) /2.0)
#   }
#   
#   predictedCPUE[[nobs]]<<- r -
#     (r / q * k) *
#     ((observedCPUE[nobs] + observedCPUE[nobs]) / 2.0) -
#     q * ((observedEffort[nobs] + observedEffort[nobs]) / 2.0)
#          
# }
# 
# 


norm2<-adinr$variable()
norm2$set_value(0.0)

# objective_function<-function(){
#   shaeffer()
#   for(i in 1:nobs){
#     norm2<<-norm2 + pow(observedCPUE[i] - predictedCPUE[[i]], 2.0)
#   }
# }
# objective_function()
# 

for ( i in 1:nobs) {
  # predictedCPUE[[i]]<- r -
  #   (r / q * k) *
  #   observedCPUE[i] -
  #   q * observedEffort[i];

  # norm2<-norm2 + pow(observedCPUE[i] - predictedCPUE[[i]], 2.0)
  
    predictedCPUE[[i]]<- r -
      (r / q * k) *
      ((observedCPUE[i] + observedCPUE[i]) / 2.0) -
      q * ((observedEffort[i] + observedEffort[i]) / 2.0)

   norm2<-norm2 + pow(observedCPUE[i] - predictedCPUE[[i]], 2.0)
}

f<-(nobs*0.5)*log(norm2)
f$value()


#minimize the objective function
results <- adinr$minimize() #<-nlminb(start = adinr$parameter_values(),objective=adinr$evaluate, gradient=adinr$gradient)

print(results)
print(adinr$gradient(results$par))
predicted <- c(1:length(nobs))

for(i in 1:nobs){
  predicted[i]<-predictedCPUE[[i]]$value()
}
plot.new()
plot(x=time, y=observedCPUE)
lines(time,predicted)

adinr$clear()
results
