

test_that("cos", {
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  x<-adinr$parameter()
  adinr$set_recording(TRUE)
 
  f<-adinr$cos(x)
  
  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 0, 1e-4)
  
  
})

test_that("sin", {
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  x<-adinr$parameter()
  adinr$set_recording(TRUE)
  
  f<-adinr$sin(x)
  
  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})


test_that("tan", {
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  x<-adinr$parameter()
  adinr$set_recording(TRUE)
  
  f<-adinr$sin(x)
  
  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("acos", {
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  x<-adinr$parameter()
  adinr$set_recording(TRUE)
  
  f<-adinr$acos(x)
  
  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], -1, 1e-4)
  
  
})

test_that("asin", {
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  x<-adinr$parameter()
  adinr$set_recording(TRUE)
  
  f<-adinr$asin(x)
  
  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("atan", {
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  x<-adinr$parameter()
  adinr$set_recording(TRUE)
  
  f<-adinr$atan(x)
  
  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("cosh", {
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  x<-adinr$parameter()
  adinr$set_recording(TRUE)
  
  f<-adinr$cosh(x)
  
  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 0, 1e-4)
  
  
})

test_that("sinh", {
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  x<-adinr$parameter()
  adinr$set_recording(TRUE)
  
  f<-adinr$sinh(x)
  
  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("tanh", {
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  x<-adinr$parameter()
  adinr$set_recording(TRUE)
  
  f<-adinr$tanh(x)
  
  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("exp", {
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  x<-adinr$parameter()
  adinr$set_recording(TRUE)
  
  f<-adinr$exp(x)
  
  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})


test_that("log", {
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  x<-adinr$parameter()
  x$set_value(1.0)
  adinr$set_recording(TRUE)
  
  f<-adinr$log(x)
  
  gradient<-adinr$gradient(c(0))
  expect_equal(gradient[1], 1, 1e-4)
  
  
})

test_that("addvv", {
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
  adinr<-Rcpp::Module("adinr", PACKAGE="ADinR")
  adinr$clear()
  x<-adinr$parameter()
  x$set_value(1.0)
  
  y<-adinr$parameter()
  y$set_value(1.0)
  adinr$set_recording(TRUE)
  
  f<-adinr$divvv(x,y)
  
  gradient<-adinr$gradient(c(1,1))
  expect_equal(gradient[1], 1, 1e-4)
  expect_equal(gradient[2], -1, 1e-4)
})

test_that("divvd", {
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
  expect_equal(gradient[2], 0, 1e-4)
})
