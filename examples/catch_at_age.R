# remotes::install_github("nmfs-fish-tools/ADinR")

library(Rcpp)
library(nloptr)
library(ADinR)

adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")

#helper functions
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

make_variable_list<-function(length){
    l<-list()
    for(i in 1:length){
        l[[i]]<-adinr$variable()
    }
    return(l)
}

# setwd("/Users/mattadmin/ADinR/examples")

load("catch_at_age.RData")


nyears<-om_input[["nyr"]]
nages<-om_input[["nages"]]

#DATA
age_composition<-em_input[["L.age.obs"]][["fleet1"]]
observed_catch_abundance<-em_input[["L.obs"]][["fleet1"]]
cv<-em_input[["cv.L"]][["fleet1"]]
empirical_waa<-om_input[["W.kg"]]



#PARAMETERS

#beverton-holt recruitment model
log_R0<-adinr$parameter()
log_R0$set_value(log(om_input[["R0"]]/1000))

h<-adinr$variable()
h$set_value(om_input[["h"]])

recruitment_deviation<-list()
for(i in 1:nyears){
    recruitment_deviation[[i]]<-adinr$parameter()
    recruitment_deviation[[i]]$set_value(0.5)
    recruitment_deviation[[i]]$bounds(-10,10)
}

#virgin spawning biomass
log_S0<-adinr$variable()
log_S0$set_value(log(om_input$R0 * om_input$Phi.0))

#initial numbers
i_n<-c(993947.5,811707.8,661434.4,537804.8,436664.0,354303.35,287396.97,1237221.2,811707.8,661434.4,537804.8,436664.0)
initial_numbers<-list()
for(i in 1:nages){
    initial_numbers[[i]]<-adinr$variable()
    initial_numbers[[i]]$set_value(i_n[i]/1000)
}

initial_deviations<-list()
for(i in 1:nages){
    initial_deviations[[i]]<-adinr$variable()
    initial_deviations[[i]]$set_value(0.5)
}

#logistic selectivity
slope<-adinr$variable()
slope$set_value(om_input[["sel_fleet"]][["fleet1"]][["slope.sel"]])
slope$bounds(0.0001,nages)
a50<-adinr$variable()
a50$set_value(om_input[["sel_fleet"]][["fleet1"]][["A50.sel"]])
a50$bounds(0.0001,nages)

#fishing mortality
fishing_mortality<-list()
for(i in 1:nyears){
    fishing_mortality[[i]]<-adinr$variable()
    fishing_mortality[[i]]$set_value(0.5)
    fishing_mortality[[i]]$bounds(0.001,4.00)
}

#natural mortality
natural_mortality<-list()
for(i in 1:nages){
    natural_mortality[[i]]<-adinr$variable()
    natural_mortality[[i]]$set_value(om_input[["M"]])
}

#maturity
maturity<-list()
for(i in 1:nages){
    maturity[[i]]<-adinr$variable()
    maturity[[i]]$set_value(om_input[["mat.age"]][[i]])
}

#derived quantities
N<-make_nested_variable_list(nyears,nages)


#spawining stock biomass at age
spawning_biomass_at_age<-make_nested_variable_list(nyears,nages)


#spawining stock biomass
SSB<-list()
for(i in 1:nyears){
    SSB[[i]]<-adinr$variable()
}

#recruitment
recruitment<-list()
for(i in 1:nyears){
    recruitment[[i]]<-adinr$variable()
}

#total mortality
Z<-make_nested_variable_list(nyears,nages)

#survival rate
S<-make_nested_variable_list(nyears,nages)

#f at age
f_at_age<-make_nested_variable_list(nyears,nages)

#catch at age
C<-make_nested_variable_list(nyears,nages)

#computed age composition
predicted_age_composition<-make_nested_variable_list(nyears,nages)

#computed catch abundance
predicted_catch_abundance<-make_variable_list(nyears)

adinr$set_recording(TRUE)

#STATISTICAL CATCH AT AGE MODEL
reset_ssb<-function(){
    for(i in 1:nyears){
        SSB[[i]]$set_value(0.0)
    }
}

reset_abundance<-function(){
    for(i in 1:nyears){
        predicted_catch_abundance[[i]]$set_value(0.0)
    }
}

reset_naa<-function(){
    for(y in 1:nyears){
        for( a in 1:nages){
            N[[y]][[a]]$set_value(0.0)
        }
    }
}

get_selectivity<-function(age){
    return((1.0) / ((1.0) + exp(-1.0 * (om_input[["ages"]][[age]] - a50) / slope)))
}

get_recruitment<-function(SB0, sb){
    # return ( 4.0 * h * exp(log_R0) * sb) / (SB0 * (1.0 - h) + sb * (5.0 * h - 1.0))
    return(( 4.0 * h * exp(log_R0) * sb) / (SB0*(1.0 - h) + sb * (5.0 * h - 1.0)))
}

calculate_mortality<-function(year,age){

       Z[[year]][[age]]<<-(fishing_mortality[[year]]*get_selectivity(age)+natural_mortality[[age]])
       f_at_age[[year]][[age]]<<-fishing_mortality[[year]]*get_selectivity(age)
       if(age == 1){
           S[[year]][[age]]<<- 1.0
       }else{
           S[[year]][[age]]<<-exp(-1.0*Z[[year]][[age]])
       }
}


calculate_numbers_at_age<-function(year,age){

    if(year == 1){
        N[[year]][[age]]<<-(initial_numbers[[age]]) + initial_deviations[[age]]
    }else{
        if(age > 1){
            N[[year]][[age]]<<-(N[[year-1]][[age-1]]*exp(-1.0 * Z[[year-1]][[age-1]]))
        }
        if(age == nages && year > 1){
            N[[year]][[age]]<<-(N[[year]][[age]] + N[[year-1]][[age]] * exp(-1.0 * Z[[year-1]][[age]]))
        }
    }

}

calculate_spawning_biomass<-function(year){
    for(a in 1:nages){
        fecundity<-maturity[[a]]*empirical_waa[[a]]
        SSB[[year]]<<-(SSB[[year]]+((exp(-1.0 * Z[[year]][[a]]))*N[[year]][[a]])*fecundity)
    }
}

calculate_recruitment<-function(year){
    if(year == 1){
        recruitment[[year]]<<-initial_numbers[[1]]
    }else{
     recruitment[[year]]<<-get_recruitment(exp(log_S0),SSB[[year]]/1000)+recruitment_deviation[[year]]
    }
    N[[year]][[1]]<<-recruitment[[year]]#first age group
   
}

calculate_catch_at_age<-function(year,age){
    C[[year]][[age]]<<-N[[year]][[age]]*f_at_age[[year]][[age]]*(1.0-exp(-1.0*Z[[year]][[age]]))/((Z[[year]][[age]]))
    
    # C[[year]][[age]]<<-N[[year]][[age]]*(f_at_age[[year]][[age]]/(Z[[year]][[age]] + maturity[[age]]))*(1.0-exp(-1.0*Z[[year]][[age]]-maturity[[age]]))
}

calculate_catch_composition<-function(){
    for(y in 1:(nyears)){
        sum<-adinr$variable()
        for(a in 1:nages){
            sum<-sum+C[[y]][[a]]
        }

        for(a in 1:nages){
            predicted_age_composition[[y]][[a]]<<-C[[y]][[a]]/sum
        }
    }
}

calculate_catch_abundance<-function(){
    for(y in 1:(nyears)){
        for(a in 1:nages){
            predicted_catch_abundance[[y]]<<-predicted_catch_abundance[[y]]+C[[y]][[a]]*empirical_waa[[a]]
        }
    }
}

calculate_catch_likelihood<-function(){
    
    l<-adinr$variable()
    for(i in 1:nyears){
        obs<-observed_catch_abundance[i]
        predicted<-predicted_catch_abundance[[i]]
        l<-l+(-1.0*log(cv)-0.5*pow((((log(obs) - log(predicted))/predicted)),2.0))
        }
    return(l)
}

calculate_index_of_abundance_likelihood<-function(){
    l<-adinr$variable()
    sample_size<-em_input[["n.L"]][["fleet1"]]
    for(i in 1:nyears){
        p<-adinr$variable()
        for(j in 1:nages){
            obs<-age_composition[i,j]
            predicted<-predicted_age_composition[[i]][[j]]+1e-8
            p<-p + obs*log(predicted)
        }
        l<-l+sample_size*p
       
    }
    return(l)
}


objective_function<-function(){
    reset_ssb()
    reset_abundance()
    reset_naa()
    for(y in 1:(nyears)){

        for(a in 1:nages){
            
            calculate_mortality(y,a)
            calculate_numbers_at_age(y,a)
            
            if(a == nages){
                calculate_spawning_biomass(y)
                calculate_recruitment(y)
            }
            calculate_catch_at_age(y,a)
        }
    }
    calculate_catch_composition()
    calculate_catch_abundance()
    n1<-calculate_catch_likelihood()
    n2<-calculate_index_of_abundance_likelihood()
    print(n1$value())
    print(n2$value())
    likelihood<- n1+n2 
    return(likelihood)
}

f<-objective_function()

x<-adinr$parameter_values()
#fit the model
results<-adinr$minimize()
#results<-nlminb(start =x,objective=adinr$evaluate, gradient=adinr$gradient)
print(results)

print(log_R0$value())
for(y in 1:nyears){
    print(paste("year = ",y))
    for(a in 1:nages){
        cat(paste(N[[y]][[a]]$value(), "  "))
    }
}

adinr$clear()
