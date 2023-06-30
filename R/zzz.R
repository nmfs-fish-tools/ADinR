# .onLoad <- function(libname, pkgname) {
#   print("loading ADinR...")
#   library.dynam("ADinR", pkgname, libname)
#  # source(ADinR/R/ops/operators.hpp)
# }



.LastLib <- function(libpath)
 {
   print("unloading ADinR")
   library.dynam.unload("ADinR", libpath)
}
