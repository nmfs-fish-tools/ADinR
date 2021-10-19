.onLoad <- function(libname, pkgname) {
  print("loading ADinR")
  library.dynam("ADinR", pkgname, libname)
  source("operators.R")
}



.LastLib <- function(libpath)
 {
   print("unloading ADinR")
   library.dynam.unload("ADinR", libpath)
}
