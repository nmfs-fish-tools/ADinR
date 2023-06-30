#library(methods)

# 
# 
# setGeneric("pow", function(e1,e2)
#   standardGeneric("pow"))
# 
# setMethod("pow", signature(e1 = "Rcpp_variable", e2 = "Rcpp_variable"), function (e1, e2)
#   adinr$powvv(e1, e2))
# setMethod("pow", signature(e1 = "Rcpp_variable", e2 = "numeric"), function (e1, e2)
#   adinr$powvd(e1, e2))
# setMethod("pow", signature(e1 = "numeric", e2 = "Rcpp_variable"), function (e1, e2)
#   adinr$powdv(e1, e2))
# 
# # setGeneric("acos", function(e1)
# #   standardGeneric("acos"))
# # setGeneric("asin", function(e1)
# #   standardGeneric("asin"))
# # setGeneric("atan", function(e1)
# #   standardGeneric("atan"))
# # setGeneric("cos", function(e1)
# #   standardGeneric("cos"))
# # setGeneric("cosh", function(e1)
# #   standardGeneric("cosh"))
# # setGeneric("sin", function(e1)
# #   standardGeneric("sin"))
# # setGeneric("sinh", function(e1)
# #   standardGeneric("sinh"))
# # setGeneric("tan", function(e1)
# #   standardGeneric("tan"))
# # setGeneric("tanh", function(e1)
# #   standardGeneric("tanh"))
# # setGeneric("exp", function(e1)
# #   standardGeneric("exp"))
# # setGeneric("log", function(e1)
# #   standardGeneric("log"))
# # setGeneric("log10", function(e1)
# #   standardGeneric("log10"))
# # setGeneric("sqrt", function(e1)
# #   standardGeneric("sqrt"))
# 
# 
# setMethod("Ops", signature(e1 = "Rcpp_variable", e2 = "Rcpp_variable"),
#           function(e1, e2) callGeneric(e1, e2))
# 
# setMethod("Ops", signature(e1 = "Rcpp_variable", e2 = "numeric"),
#           function(e1, e2) callGeneric(e1, e2))
# 
# setMethod("Ops", signature(e1 = "numeric", e2 = "Rcpp_variable"),
#           function(e1, e2) callGeneric(e1, e2))
# 
# # setMethod("Math", signature(e1 = "numeric", e2 = "Rcpp_variable"),
# #           function(e1, e2) callGeneric(e1, e2))
# 
# #pow
# #/
# 
# 
# #+
# setMethod("+", signature(e1 = "Rcpp_variable", e2 = "Rcpp_variable"), function (e1, e2){
#   return(adinr$addvv(e1, e2))})
# setMethod("+", signature(e1 = "Rcpp_variable", e2 = "numeric"), function (e1, e2){
#   return(adinr$addvd(e1, e2))})
# setMethod("+", signature(e1 = "numeric", e2 = "Rcpp_variable"), function (e1, e2){
#   return(adinr$adddv(e1, e2))})
# #-
# setMethod("-", signature(e1 = "Rcpp_variable", e2 = "Rcpp_variable"), function (e1, e2)
#   adinr$subvv(e1, e2))
# setMethod("-", signature(e1 = "Rcpp_variable", e2 = "numeric"), function (e1, e2)
#   adinr$subvd(e1, e2))
# setMethod("-", signature(e1 = "numeric", e2 = "Rcpp_variable"), function (e1, e2)
#   adinr$subdv(e1, e2))
# 
# #*
# setMethod("*", signature(e1 = "Rcpp_variable", e2 = "Rcpp_variable"), function (e1, e2)
#   adinr$multvv(e1, e2))
# setMethod("*", signature(e1 = "Rcpp_variable", e2 = "numeric"), function (e1, e2){
#   return(adinr$multvd(e1, e2))})
# setMethod("*", signature(e1 = "numeric", e2 = "Rcpp_variable"), function (e1, e2)
#   adinr$multdv(e1, e2))
# 
# #/
# setMethod("/", signature(e1 = "Rcpp_variable", e2 = "Rcpp_variable"), function (e1, e2)
#   adinr$divvv(e1, e2))
# setMethod("/", signature(e1 = "Rcpp_variable", e2 = "numeric"), function (e1, e2)
#   adinr$divvd(e1, e2))
# setMethod("/", signature(e1 = "numeric", e2 = "Rcpp_variable"), function (e1, e2)
#   adinr$divdv(e1, e2))
# 
# 
# 
# 
# 
# 
# 
# 
# # setMethod("Math", c(x="Rcpp_variable"),
# #           function(x)
# #           {
# #             op = .Generic[[1]]
# #             switch(op,
# #                    `log` = adinr$log(x),
# #                    stop("Undefined operation")
# #             )
# #           }
# # )
# # 
# # # setMethod("ad_acos", signature(e1 = "Rcpp_variable_matrix"), function (e1) adinr$acos_1(e1))
# # # setMethod("ad_acos", signature(e1 = "Rcpp_variable"), function (e1) adinr$acos_2(e1))
# # # setMethod("ad_acos", signature(e1 = "Rcpp__matrix"), function (e1) adinr$acos_3(e1))
# setMethod("acos", signature(x = "Rcpp_variable"), function (x) adinr$acos(e1))
# setMethod("asin", signature(x = "Rcpp_variable"), function (x) adinr$asin(x))
# setMethod("atan", signature(x = "Rcpp_variable"), function (x) adinr$atan(x))
# setMethod("cos", signature(x = "Rcpp_variable"), function (x) adinr$cos(x))
# setMethod("cosh", signature(x = "Rcpp_variable"), function (x) adinr$cosh(x))
# setMethod("sin", signature(x = "Rcpp_variable"), function (x) adinr$sin(x))
# setMethod("sinh", signature(x = "Rcpp_variable"), function (x) adinr$sinh(x))
# setMethod("tan", signature(x = "Rcpp_variable"), function (x) adinr$tan(x))
# setMethod("tanh", signature(x = "Rcpp_variable"), function (x) adinr$tanh(x))
# setMethod("exp", signature(x = "Rcpp_variable"), function (x) adinr$exp(x))
# # setMethod("ad_log", signature(e1 = "Rcpp_variable"), function (e1) adinr$log(e1))
# setMethod("log10", signature(x = "Rcpp_variable"), function (x) adinr$log10(x))
# setMethod("sqrt", signature(x = "Rcpp_variable"), function (x) adinr$sqrt(x))
# setMethod("log", signature(x = "Rcpp_variable"), function (x, base=exp(1)){return(adinr$log(x))})
# 
