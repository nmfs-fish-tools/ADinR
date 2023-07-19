library(ADinR)

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


setwd("/Users/mattadmin/ADinR-Testing/ADinR/examples/")

#DATA
load("catch_at_age.RData")

nyrs<-om_input[["nyr"]]
nages<-om_input[["nages"]]
ages<-om_input[["ages"]]
M<-rep(om_input[["M"]], nages)
mat.age<-om_input[["mat.age"]]
W.mt<-om_input[["W.mt"]]
W.kg<-om_input[["W.kg"]]
Phi.0<-om_input[["Phi.0"]]


#DERIVED QUANTITIES
L.mt<-make_variable_list(nyrs)
knum<-make_variable_list(nyrs)
L.age<-make_nested_variable_list(nyrs, nages)
abundance<-make_variable_list(nyrs)
biomass.mt<-make_variable_list(nyrs)
Z<-make_nested_variable_list(nyrs, nages)
N<-make_nested_variable_list(nyrs, nages)

Phi.F<-list()
BC #bias correction
SSB<-make_variable_list(nyrs)
FAA<-make_variable_list(nyrs)


#ESTIMATED PARAMETERS
R0<-Parameter()
R0$set_value(om_input[["R0"]])

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


#record model to the tape
SetRecording(TRUE)


R.eq=R0*(1.0+log(Phi.F/Phi.0)/h)/(Phi.F/Phi.0)

for(i in 1:(nyrs-1)){
  for(j in 1:nages){
    selex_fleet<-
  Z=f[[i]][[j]]*selex_fleet$fleet1 + M.age
  }
  
  
  
}


  