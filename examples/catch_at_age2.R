library(ADinR)
ADinR::Clear()

#helper functions
make_nested_variable_list<-function(rows,cols){
  l<-list()
  for(i in 1:rows){
    r<-list()
    for(j in 1:cols){
      r[[j]]<-Variable()
    }
    l[[i]]<-r
  }
  return(l)
}

make_variable_list<-function(length){
  l<-list()
  for(i in 1:length){
    l[[i]]<-Variable()
  }
  return(l)
}

make_nested_parameter_list<-function(rows,cols){
  l<-list()
  for(i in 1:rows){
    r<-list()
    for(j in 1:cols){
      r[[j]]<-Parameter()
    }
    l[[i]]<-r
  }
  return(l)
}

make_parameter_list<-function(length){
  l<-list()
  for(i in 1:length){
    l[[i]]<-Parameter()
  }
  return(l)
}


setwd("/Users/mattadmin/ADinR-Testing/ADinR/examples/")

#DATA
load("catch_at_age.RData")

nyrs<-om_input[["nyr"]]
nages<-om_input[["nages"]]
ages<-om_input[["ages"]]
M.age<-rep(om_input[["M"]], nages)
mat.age<-om_input[["mat.age"]]
W.mt<-om_input[["W.mt"]]
W.kg<-om_input[["W.kg"]]
Phi.0<-om_input[["Phi.0"]]
prop.f<-om_input[["proportion.female"]]
L.obs<- em_input[["L.obs"]][["fleet1"]]
L.age.obs<- em_input[["L.age"]]


#DERIVED QUANTITIES
L.mt<-make_variable_list(nyrs)
L.knum<-make_variable_list(nyrs)
L.age<-make_nested_variable_list(nyrs, nages)
abundance<-make_variable_list(nyrs)
biomass.mt<-make_variable_list(nyrs)
Z<-make_nested_variable_list(nyrs, nages)
N.age<-make_nested_variable_list(nyrs, nages)
N.pr1<-make_variable_list(nages)
reprod<-make_variable_list(nages)
Phi.F<-0.0
#BC #bias correction
SSB<-make_variable_list(nyrs)
FAA<-make_nested_variable_list(nyrs,nages)
prop.age<-make_nested_variable_list(nyrs,nages)
index<-make_variable_list(nyrs)


#ESTIMATED PARAMETERS
R0<-Parameter()
R0$set_value(om_input[["R0"]])
h<-om_input[["h"]]

#fleet selectivity
fleet.A50.sel<-Parameter()
fleet.A50.sel$set_value(om_input[["sel_fleet"]][["fleet1"]][["A50.sel"]])
fleet.slope.sel<-Parameter()
fleet.slope.sel$set_value(om_input[["sel_fleet"]][["fleet1"]][["slope.sel"]])

#survey selectivity
survey.A50.sel<-Parameter()
survey.A50.sel$set_value(om_input[["sel_survey"]][["survey1"]][["A50.sel"]])
survey.slope.sel<-Parameter()
survey.slope.sel$set_value(om_input[["sel_survey"]][["survey1"]][["slope.sel"]])

f<-make_parameter_list(nyrs)
for(i in 1:nyrs){
  f[[i]]$set_value(0.1)
}


#record model to the tape
SetRecording(TRUE)


for(a in 1:nages){
  reprod[[a]]<-prop.f[[a]]*mat.age[[a]]*W.mt[[a]]
  N.pr1[[a]]$set_value(1.0)
  selex_fleet<-(1.0) / 
    (1.0 + exp(-1.0 * 
                 fleet.slope.sel * (ages[[a]] - fleet.A50.sel)));
  Z[[1]][[a]]<-f[[1]]*selex_fleet*M.age[[a]]
}

for(a in 1:(nages-1)){
  N.pr1[[a+1]]<-N.pr1[[a]]*exp(-1.0*Z[[1]][[a]])
}

N.pr1[[nages]]<-N.pr1[[nages]]/(1.0-exp(-1.0*Z[[1]][[nages]]))

for(a in 1:(nages)){
  Phi.F<- Phi.F + N.pr1[[a]]*reprod[[a]]
}

R.eq=R0*(1.0+log(Phi.F/Phi.0)/h)/(Phi.F/Phi.0)

for(a in 1:nages){
  N.age[[1]][[a]]=R.eq*N.pr1[[a]]
}

for(y in 1:(nyrs-1)){
  for(a in 1:nages){
    selex_fleet<-(1.0) / (1.0 + exp(-1.0 * 
                                      fleet.slope.sel * (ages[[a]] - fleet.A50.sel)));
    Z[[y]][[a]]<-f[[y]]*selex_fleet + M.age[[a]]
    FAA[[y]][[a]]=f[[y]]*selex_fleet
    SSB[[y]]<- SSB[[y]] + N.age[[y]][[a]]*reprod[[a]]
    
  }
  recruits<-(0.8*R0*h* SSB[[y]])/(0.2*R0*Phi.0*(1-h) +  SSB[[y]]*(h-0.2))
  N.age[[y+1]][[1]]<-recruits
  
  
  for(a in 1:(nages-1)){
    #Abundance at age in each year
    N.age[[y+1]][[a+1]]<-N.age[[y]][[a]]*exp(-1.0*Z[[y]][[a]])
  }
  #Plus group correction
  N.age[[y+1]][[nages]]<-N.age[[y+1]][[nages]] + N.age[[y]][[nages]]*exp(-1.0*Z[[y]][[nages]]) 
  
  for(a in 1:nages){
    selex_fleet<-(1.0) / (1.0 + exp(-1.0 * 
                                      fleet.slope.sel * (ages[[a]] - fleet.A50.sel)));
    L.age[[y]][[a]]<-f[[y]]*selex_fleet/(Z[[y]][[a]])*N.age[[y]][[a]]*(1.0-exp(-1.0*Z[[y]][[a]]))
    L.knum[[y]]<-L.knum[[y]] + (L.age[[y]][[a]])
    L.mt[[y]]<-L.age[[y]][[a]]*W.mt[[a]]
    abundance[[y]]=N.age[[y]][[a]]
    biomass.mt[[y]]<-N.age[[y]][[a]]*W.mt[[a]]
  }
  L.knum[[y]]<-L.knum[[y]]/1000.0
  
}

for(a in 1:nages){
  selex_fleet<-(1.0) / (1.0 + exp(-1.0 * 
                                    fleet.slope.sel * (ages[[a]] - fleet.A50.sel)));
  Z[[nyrs]][[a]]<-f[[nyrs]]*selex_fleet + M.age[[a]]
  FAA[[nyrs]][[a]]<-f[[nyrs]]*selex_fleet
  SSB[[nyrs]]<-SSB[[nyrs]]+N.age[[nyrs]][[a]]*reprod[[a]]
  L.age[[nyrs]][[a]]<-f[[nyrs]]*selex_fleet/(Z[[nyrs]][[a]])*N.age[[nyrs]][[a]]*(1.0-exp(-1.0*Z[[nyrs]][[a]]))
  L.knum[[nyrs]]<-L.knum[[nyrs]] + L.age[[nyrs]][[a]]/1000
  L.mt[[nyrs]]<-L.mt[[nyrs]] + L.age[[nyrs]][[a]]*W.mt[[a]]
  abundance[[nyrs]]<-abundance[[nyrs]]+ N.age[[nyrs]][[a]]
  biomass.mt[[nyrs]]<-biomass.mt[[nyrs]] + N.age[[nyrs]][[a]]*W.mt[[a]]
}

for (y in 1:nyrs) {
  sum<-Variable()
  for(a in 1:nages){
    sum<-sum+N.age[[y]][[a]]
  }
  
  for(a in 1:nages){
    prop.age[[y]][[a]]<-N.age[[y]][[a]]/sum
  }
  
}

#likelihood components
nll1<-Variable()
nll2<-Variable()

#calculate catch likelihood
cv<-em_input[["cv.L"]][["fleet1"]]
for(i in 1:nyrs){
  print(i)
  obs<-L.obs[[i]]
  predicted<-L.knum[[i]]
  nll1<-nll1+(-1.0*log(cv)-0.5*pow(((log(obs) - log(predicted))/predicted),2.0))
}


sample_size<-em_input[["n.L"]][["fleet1"]]
obs.prop<-em_input[["L.age.obs"]][["fleet1"]]

for(i in 1:nyrs){
  p<-Variable()
  for(j in 1:nages){
    index<- ((i-1)*nages+j)#dimension folded
    print(index)
    predicted<-prop.age[[i]][[j]]
    p<-p + obs.prop[[index]]*log(predicted)
  }
  nll2<-nll2+sample_size*p
  
}

nll<-nll1+nll2

SetRecording(FALSE)

results<-Minimize()
print(results)
