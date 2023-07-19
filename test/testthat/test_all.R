
Sys.setenv(R_TESTS = "")
#remotes::install_github("nmfs-fish-tools/ADinR")
library(testthat)
library(methods)
#library(Rcpp)
library(ADinR)

test_that("cos", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  adinr$set_recording(TRUE)
 
  f<-adinr$cos(x)
  
  gradient<-adinr$gradient(c(0))
  print(gradient)
  expect_equal(gradient[1], 0, 1e-4)
  
  
})

test_that("sin", {
#library(Rcpp)
  library(ADinR)
  # adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  
  adinr$set_recording(TRUE)

  f<-adinr$sin(x)

  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})


test_that("tan", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  
  adinr$set_recording(TRUE)

  f<-adinr$tan(x)

  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("acos", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  
  
  adinr$set_recording(TRUE)
  f<-adinr$acos(x)

  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], -1, 1e-4)


})

test_that("asin", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  
  adinr$set_recording(TRUE)

  f<-adinr$asin(x)

  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("atan", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  
  adinr$set_recording(TRUE)

  f<-adinr$atan(x)

  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("cosh", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  
  adinr$set_recording(TRUE)

  f<-adinr$cosh(x)

  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 0, 1e-4)


})

test_that("sinh", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  
  adinr$set_recording(TRUE)

  f<-adinr$sinh(x)

  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("tanh", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  
  adinr$set_recording(TRUE)

  f<-adinr$tanh(x)

  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("exp", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  
  adinr$set_recording(TRUE)

  f<-adinr$exp(x)

  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("adinr log",{
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)
  
  adinr$set_recording(TRUE)
  
  f<-adinr$log(x)
  
  gradient<-adinr$gradient(c(0.0))
  expect_equal(gradient[1], Inf, 1e-4)
})

test_that("addvv", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$addvv(x,y)

  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], 1, 1e-4)

})

test_that("addvd", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$addvd(x,1.0)

  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("adddv", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$adddv(1.0,x)

  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("subvv", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$subvv(x,y)

  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], -1, 1e-4)

})

test_that("subvd", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$subvd(x,1)

  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)

})

test_that("subdv", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$subdv(1,x)

  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], -1, 1e-4)

})

test_that("multvv", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$multvv(x,y)


  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], 1, 1e-4)

})

test_that("multvd", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$multvd(x,1.0)

  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)

})

test_that("multdv", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$multdv(1.0,x)

  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)

})

test_that("divvv", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$divvv(x,y)

  gradient<-adinr$gradient(c(1,1))
  gradient
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], -1, 1e-4)
})

test_that("divvd", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$divvd(x,1.0)

  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], 0, 1e-4)
})

test_that("divdv", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$divdv(1.0,x)
  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], -1, 1e-4)
  expect_equal(gradient[2], 0, 1e-4)
})

test_that("powvv", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)
  x
  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$powvv(x,y)
  
  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], 0, 1e-4)
})

test_that("powvd", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$powvd(x, 2.0)
  
  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 2, 1e-4)
  expect_equal(gradient[2], 0, 1e-4)
})

test_that("powdv", {
#library(Rcpp)
  library(ADinR)
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  
  x<-adinr$parameter()
  x$set_value(1.0)

  y<-adinr$parameter()
  y$set_value(1.0)
  
  adinr$set_recording(TRUE)

  f<-adinr$powdv(2.0,x)
  
  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 1.38629, 1e-4)
})

#Top Level


test_that("Cos top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Cos(x)
  
  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 0, 1e-4)
  
  
})

test_that("Sin top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Sin(x)
  
  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})


test_that("Tan top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Tan(x)
  
  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("ACos top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::ACos(x)
  
  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], -1, 1e-4)
  
  
})

test_that("ASin top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::ASin(x)
  
  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("ATan top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::ATan(x)
  
  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("Cosh top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Cosh(x)
  
  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 0, 1e-4)
  
  
})

test_that("Sinh top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Sinh(x)
  
  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("Tanh top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Tanh(x)
  
  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("Exp top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Exp(x)
  
  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})


test_that("Log top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Log(x)
  
  gradient<-ADinR::Gradient(c(0))
  gradient
  expect_equal(gradient[1], Inf, 1e-4)
  
})

test_that("ADD VV top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)
  
  y<-ADinR::Parameter()
  y$set_value(1.0)

  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Add(x,y)
  
  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], 1, 1e-4)
  
})

test_that("Add vd top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)
  
  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Add(x,1.0)
  
  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("Add dv top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  x<-ADinR::Parameter()
  x$set_value(1.0)
  
  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Add(1.0,x)
  
  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("Sub top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)

  f<-Sub(x,y)

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], -1, 1e-4)

})

test_that("Sub vd top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)

  f<-ADinR::Sub(x,1.0)

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)

})

test_that("Sub dv top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)

  f<-ADinR::Sub(1,x)

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], -1, 1e-4)

})

test_that("Mult vv top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)

  f<-ADinR::Mult(x,y)

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], 1, 1e-4)

 })

test_that("Mult vd top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)

  f<-ADinR::Mult(x,1.0)

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)

})

test_that("Mult dv top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)

  f<-ADinR::Mult(1.0,x)

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)

})

test_that("Div vv top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)

  f<-ADinR::Div(x,y)

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], -1, 1e-4)
})

test_that("Div vd top-level" , {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)

  f<-ADinR::Div(x,1.0)

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], 0, 1e-4)
})

test_that("Div dv top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)
  
  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Div(1.0,x)
  
  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], -1, 1e-4)
  expect_equal(gradient[2], 0, 1e-4)
})

test_that("Pow vv top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)
  
  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)

  f<-ADinR::Pow(x,y)
  gradient<-ADinR::Gradient(c(1,1))
  
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], 0, 1e-4)
})

test_that("Pow vd top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)
  
  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Pow(x,2.0)
  
  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 2, 1e-4)
  expect_equal(gradient[2], 0, 1e-4)
})

test_that("Pow dv top-level", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)
  
  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)
  
  f<-ADinR::Pow(2.0,x)
  
  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1.38629, 1e-4)
})

#methods


test_that("cos methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)
  
  f<-cos(x)
  
  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 0, 1e-4)
  
  
})

test_that("sin methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)

  f<-sin(x)

  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})


test_that("tan methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)

  f<-tan(x)

  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("acos methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)
  
  f<-acos(x)

  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], -1, 1e-4)


})

test_that("asin methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)

  f<-asin(x)

  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("atan methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)

  f<-atan(x)

  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("cosh methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)

  f<-cosh(x)

  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 0, 1e-4)


})

test_that("sinh methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)

  f<-sinh(x)

  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("tanh methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)

  f<-tanh(x)

  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("exp methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  
  ADinR::SetRecording(TRUE)

  f<-exp(x)

  gradient<-ADinR::Gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("log methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)
  
  ADinR::SetRecording(TRUE)

  f<-log(x)

  gradient<-ADinR::Gradient(c(0))
  gradient
  expect_equal(gradient[1], Inf, 1e-4)

})

test_that("operator + VV methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)
  
  f<-x+y

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], 1, 1e-4)

})

test_that("operator + vd methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)

  ADinR::SetRecording(TRUE)
  
  f<-x+1

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("operator + dv methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)

  ADinR::SetRecording(TRUE)
  
  f<-1.0+x

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)


})

test_that("operator - methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)

  f<-x-y

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], -1, 1e-4)

})

test_that("operator - vd methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)
  
  ADinR::SetRecording(TRUE)

  f<-x-1.0

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)

})

test_that("operator - dv methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)

  ADinR::SetRecording(TRUE)

  f<- 1.0-x

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], -1, 1e-4)

})

test_that("operator * vv methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()

  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)

  ADinR::SetRecording(TRUE)

  f<-x*y

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], 1, 1e-4)

})

test_that("operator * vd methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)

  ADinR::SetRecording(TRUE)

  f<-x*1

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)

})

test_that("operator * dv methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)
  ADinR::SetRecording(TRUE)

  f<- 1.0*x

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)

})

test_that("operator / vv methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()
  
  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)

  ADinR::SetRecording(TRUE)

  f<-x/y

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], -1, 1e-4)
})

test_that("operator / vd methods" , {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()

  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)

  ADinR::SetRecording(TRUE)

  f<-x/1.0

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], 0, 1e-4)
})

test_that("operator / dv methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()

  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)

  ADinR::SetRecording(TRUE)

  f<-1.0/x

  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], -1, 1e-4)
  expect_equal(gradient[2], 0, 1e-4)
})

test_that("pow vv methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()

  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)

  ADinR::SetRecording(TRUE)

  f<-pow(x,y)
  gradient<-ADinR::Gradient(c(1,1))

  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], 0, 1e-4)
})

test_that("pow vd methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()

  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)

  ADinR::SetRecording(TRUE)

  f<-pow(x,2.0)
  gradient<-ADinR::Gradient(c(1,1))

  expect_equal(gradient[1], 2, 1e-4)
  expect_equal(gradient[2], 0, 1e-4)
})

test_that("pow dv methods", {
#library(Rcpp)
  library(ADinR)
  ADinR::Clear()

  x<-ADinR::Parameter()
  x$set_value(1.0)

  y<-ADinR::Parameter()
  y$set_value(1.0)

  ADinR::SetRecording(TRUE)

  f<-pow(2.0,x)
  gradient<-ADinR::Gradient(c(1,1))
  expect_equal(gradient[1], 1.38629, 1e-4)
})

