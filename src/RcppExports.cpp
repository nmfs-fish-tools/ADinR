// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// MakeEstimable
void MakeEstimable(SEXP v);
RcppExport SEXP _ADinR_MakeEstimable(SEXP vSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type v(vSEXP);
    MakeEstimable(v);
    return R_NilValue;
END_RCPP
}
// Variable
const SEXP Variable();
RcppExport SEXP _ADinR_Variable() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(Variable());
    return rcpp_result_gen;
END_RCPP
}
// Parameter
const SEXP Parameter();
RcppExport SEXP _ADinR_Parameter() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(Parameter());
    return rcpp_result_gen;
END_RCPP
}
// GetValues
SEXP GetValues();
RcppExport SEXP _ADinR_GetValues() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(GetValues());
    return rcpp_result_gen;
END_RCPP
}
// Show
void Show(SEXP v);
RcppExport SEXP _ADinR_Show(SEXP vSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type v(vSEXP);
    Show(v);
    return R_NilValue;
END_RCPP
}
// Gradient
const SEXP Gradient(Rcpp::NumericVector x);
RcppExport SEXP _ADinR_Gradient(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(Gradient(x));
    return rcpp_result_gen;
END_RCPP
}
// Clear
void Clear();
RcppExport SEXP _ADinR_Clear() {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Clear();
    return R_NilValue;
END_RCPP
}
// SetRecording
void SetRecording(bool record);
RcppExport SEXP _ADinR_SetRecording(SEXP recordSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< bool >::type record(recordSEXP);
    SetRecording(record);
    return R_NilValue;
END_RCPP
}
// Minimize
Rcpp::List Minimize(Rcpp::Nullable<Rcpp::List> control);
RcppExport SEXP _ADinR_Minimize(SEXP controlSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::Nullable<Rcpp::List> >::type control(controlSEXP);
    rcpp_result_gen = Rcpp::wrap(Minimize(control));
    return rcpp_result_gen;
END_RCPP
}
// ACos
const SEXP ACos(const SEXP& x);
RcppExport SEXP _ADinR_ACos(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const SEXP& >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(ACos(x));
    return rcpp_result_gen;
END_RCPP
}
// ASin
const SEXP ASin(SEXP x);
RcppExport SEXP _ADinR_ASin(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(ASin(x));
    return rcpp_result_gen;
END_RCPP
}
// ATan
const SEXP ATan(SEXP x);
RcppExport SEXP _ADinR_ATan(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(ATan(x));
    return rcpp_result_gen;
END_RCPP
}
// Cos
const SEXP Cos(SEXP x);
RcppExport SEXP _ADinR_Cos(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(Cos(x));
    return rcpp_result_gen;
END_RCPP
}
// Cosh
const SEXP Cosh(SEXP x);
RcppExport SEXP _ADinR_Cosh(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(Cosh(x));
    return rcpp_result_gen;
END_RCPP
}
// Sin
const SEXP Sin(SEXP x);
RcppExport SEXP _ADinR_Sin(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(Sin(x));
    return rcpp_result_gen;
END_RCPP
}
// Sinh
const SEXP Sinh(SEXP x);
RcppExport SEXP _ADinR_Sinh(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(Sinh(x));
    return rcpp_result_gen;
END_RCPP
}
// Tan
const SEXP Tan(SEXP x);
RcppExport SEXP _ADinR_Tan(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(Tan(x));
    return rcpp_result_gen;
END_RCPP
}
// Tanh
const SEXP Tanh(SEXP x);
RcppExport SEXP _ADinR_Tanh(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(Tanh(x));
    return rcpp_result_gen;
END_RCPP
}
// Exp
const SEXP Exp(SEXP x);
RcppExport SEXP _ADinR_Exp(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(Exp(x));
    return rcpp_result_gen;
END_RCPP
}
// Log
const SEXP Log(SEXP x);
RcppExport SEXP _ADinR_Log(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(Log(x));
    return rcpp_result_gen;
END_RCPP
}
// Log10
const SEXP Log10(SEXP x);
RcppExport SEXP _ADinR_Log10(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(Log10(x));
    return rcpp_result_gen;
END_RCPP
}
// Pow
const SEXP Pow(SEXP a, SEXP b);
RcppExport SEXP _ADinR_Pow(SEXP aSEXP, SEXP bSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type a(aSEXP);
    Rcpp::traits::input_parameter< SEXP >::type b(bSEXP);
    rcpp_result_gen = Rcpp::wrap(Pow(a, b));
    return rcpp_result_gen;
END_RCPP
}
// Add
const SEXP Add(SEXP a, SEXP b);
RcppExport SEXP _ADinR_Add(SEXP aSEXP, SEXP bSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type a(aSEXP);
    Rcpp::traits::input_parameter< SEXP >::type b(bSEXP);
    rcpp_result_gen = Rcpp::wrap(Add(a, b));
    return rcpp_result_gen;
END_RCPP
}
// Sub
const SEXP Sub(SEXP a, SEXP b);
RcppExport SEXP _ADinR_Sub(SEXP aSEXP, SEXP bSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type a(aSEXP);
    Rcpp::traits::input_parameter< SEXP >::type b(bSEXP);
    rcpp_result_gen = Rcpp::wrap(Sub(a, b));
    return rcpp_result_gen;
END_RCPP
}
// Mult
const SEXP Mult(SEXP a, SEXP b);
RcppExport SEXP _ADinR_Mult(SEXP aSEXP, SEXP bSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type a(aSEXP);
    Rcpp::traits::input_parameter< SEXP >::type b(bSEXP);
    rcpp_result_gen = Rcpp::wrap(Mult(a, b));
    return rcpp_result_gen;
END_RCPP
}
// Div
const SEXP Div(SEXP a, SEXP b);
RcppExport SEXP _ADinR_Div(SEXP aSEXP, SEXP bSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type a(aSEXP);
    Rcpp::traits::input_parameter< SEXP >::type b(bSEXP);
    rcpp_result_gen = Rcpp::wrap(Div(a, b));
    return rcpp_result_gen;
END_RCPP
}

RcppExport SEXP _rcpp_module_boot_adinr();

static const R_CallMethodDef CallEntries[] = {
    {"_ADinR_MakeEstimable", (DL_FUNC) &_ADinR_MakeEstimable, 1},
    {"_ADinR_Variable", (DL_FUNC) &_ADinR_Variable, 0},
    {"_ADinR_Parameter", (DL_FUNC) &_ADinR_Parameter, 0},
    {"_ADinR_GetValues", (DL_FUNC) &_ADinR_GetValues, 0},
    {"_ADinR_Show", (DL_FUNC) &_ADinR_Show, 1},
    {"_ADinR_Gradient", (DL_FUNC) &_ADinR_Gradient, 1},
    {"_ADinR_Clear", (DL_FUNC) &_ADinR_Clear, 0},
    {"_ADinR_SetRecording", (DL_FUNC) &_ADinR_SetRecording, 1},
    {"_ADinR_Minimize", (DL_FUNC) &_ADinR_Minimize, 1},
    {"_ADinR_ACos", (DL_FUNC) &_ADinR_ACos, 1},
    {"_ADinR_ASin", (DL_FUNC) &_ADinR_ASin, 1},
    {"_ADinR_ATan", (DL_FUNC) &_ADinR_ATan, 1},
    {"_ADinR_Cos", (DL_FUNC) &_ADinR_Cos, 1},
    {"_ADinR_Cosh", (DL_FUNC) &_ADinR_Cosh, 1},
    {"_ADinR_Sin", (DL_FUNC) &_ADinR_Sin, 1},
    {"_ADinR_Sinh", (DL_FUNC) &_ADinR_Sinh, 1},
    {"_ADinR_Tan", (DL_FUNC) &_ADinR_Tan, 1},
    {"_ADinR_Tanh", (DL_FUNC) &_ADinR_Tanh, 1},
    {"_ADinR_Exp", (DL_FUNC) &_ADinR_Exp, 1},
    {"_ADinR_Log", (DL_FUNC) &_ADinR_Log, 1},
    {"_ADinR_Log10", (DL_FUNC) &_ADinR_Log10, 1},
    {"_ADinR_Pow", (DL_FUNC) &_ADinR_Pow, 2},
    {"_ADinR_Add", (DL_FUNC) &_ADinR_Add, 2},
    {"_ADinR_Sub", (DL_FUNC) &_ADinR_Sub, 2},
    {"_ADinR_Mult", (DL_FUNC) &_ADinR_Mult, 2},
    {"_ADinR_Div", (DL_FUNC) &_ADinR_Div, 2},
    {"_rcpp_module_boot_adinr", (DL_FUNC) &_rcpp_module_boot_adinr, 0},
    {NULL, NULL, 0}
};

RcppExport void R_init_ADinR(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
