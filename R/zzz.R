library(methods)
library(Rcpp)

.onLoad <- function(libname, pkgname) {
  #print("loading ADinR...")
  library.dynam("ADinR", pkgname, libname)
  #load the adinr module
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  setGeneric("pow", function(e1,e2)
    standardGeneric("pow"))
  
  
  setMethod("Ops", signature(e1 = "Rcpp_variable", e2 = "Rcpp_variable"),
            function(e1, e2) callGeneric(e1, e2))
  
  setMethod("Ops", signature(e1 = "Rcpp_variable", e2 = "numeric"),
            function(e1, e2) callGeneric(e1, e2))
  
  setMethod("Ops", signature(e1 = "numeric", e2 = "Rcpp_variable"),
            function(e1, e2) callGeneric(e1, e2))
  
  # setMethod("Math", signature(e1 = "numeric", e2 = "Rcpp_variable"),
  #           function(e1, e2) callGeneric(e1, e2))
  
  #math
  setMethod("acos", signature(x = "Rcpp_variable"), function (x) ADinR::ACos(x))
  setMethod("asin", signature(x = "Rcpp_variable"), function (x) ADinR::ASin(x))
  setMethod("atan", signature(x = "Rcpp_variable"), function (x) ADinR::ATan(x))
  setMethod("cos", signature(x = "Rcpp_variable"), function (x) ADinR::Cos(x))
  setMethod("cosh", signature(x = "Rcpp_variable"), function (x) ADinR::Cosh(x))
  setMethod("sin", signature(x = "Rcpp_variable"), function (x) ADinR::Sin(x))
  setMethod("sinh", signature(x = "Rcpp_variable"), function (x) ADinR::Sinh(x))
  setMethod("tan", signature(x = "Rcpp_variable"), function (x) ADinR::Tan(x))
  setMethod("tanh", signature(x = "Rcpp_variable"), function (x) ADinR::Tanh(x))
  setMethod("exp", signature(x = "Rcpp_variable"), function (x) ADinR::Exp(x))
  setMethod("log10", signature(x = "Rcpp_variable"), function (x) ADinR::Log10(x))
  setMethod("sqrt", signature(x = "Rcpp_variable"), function (x) ADinR::Pow(x,0.5))
  setMethod("log", signature(x = "Rcpp_variable"), function (x, base=exp(1)){return(ADinR::Log(x))})
  setMethod("pow", signature(e1 = "Rcpp_variable", e2 = "Rcpp_variable"), function (e1, e2)
    ADinR::Pow(e1, e2))
  setMethod("pow", signature(e1 = "Rcpp_variable", e2 = "numeric"), function (e1, e2)
    ADinR::Pow(e1, e2))
  setMethod("pow", signature(e1 = "numeric", e2 = "Rcpp_variable"), function (e1, e2)
    ADinR::Pow(e1, e2))
  
  #+
  setMethod("+", signature(e1 = "Rcpp_variable", e2 = "Rcpp_variable"), function (e1, e2){
    return(Add(e1, e2))})
  setMethod("+", signature(e1 = "Rcpp_variable", e2 = "numeric"), function (e1, e2){
    return(Add(e1, e2))})
  setMethod("+", signature(e1 = "numeric", e2 = "Rcpp_variable"), function (e1, e2){
    return(Add(e1, e2))})
  #-
  setMethod("-", signature(e1 = "Rcpp_variable", e2 = "Rcpp_variable"), function (e1, e2)
    Sub(e1, e2))
  setMethod("-", signature(e1 = "Rcpp_variable", e2 = "numeric"), function (e1, e2)
    Sub(e1, e2))
  setMethod("-", signature(e1 = "numeric", e2 = "Rcpp_variable"), function (e1, e2)
    Sub(e1, e2))
  
  #*
  setMethod("*", signature(e1 = "Rcpp_variable", e2 = "Rcpp_variable"), function (e1, e2)
    Mult(e1, e2))
  setMethod("*", signature(e1 = "Rcpp_variable", e2 = "numeric"), function (e1, e2){
    return(Mult(e1, e2))})
  setMethod("*", signature(e1 = "numeric", e2 = "Rcpp_variable"), function (e1, e2)
    Mult(e1, e2))
  
  #/
  setMethod("/", signature(e1 = "Rcpp_variable", e2 = "Rcpp_variable"), function (e1, e2)
    Div(e1, e2))
  setMethod("/", signature(e1 = "Rcpp_variable", e2 = "numeric"), function (e1, e2)
    Div(e1, e2))
  setMethod("/", signature(e1 = "numeric", e2 = "Rcpp_variable"), function (e1, e2)
    Div(e1, e2))
}

# -------------------------------------------------------------------------




.LastLib <- function(libpath)
 {
   print("unloading ADinR")
   library.dynam.unload("ADinR", libpath)
}
