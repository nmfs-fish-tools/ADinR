library(methods)
library(Rcpp)

.onLoad <- function(libname, pkgname) {
  #print("loading ADinR...")
  library.dynam("ADinR", pkgname, libname)
  #load the adinr module
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
}

# -------------------------------------------------------------------------




.LastLib <- function(libpath)
 {
   print("unloading ADinR")
   library.dynam.unload("ADinR", libpath)
}
