/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   RInterface.hpp
 * Author: mattadmin
 *
 * Created on September 21, 2021, 4:06 PM
 */

#ifndef RINTERFACE_HPP
#define RINTERFACE_HPP

#include <Rcpp.h>
#include <valarray>
#include "operators.hpp"
#include "functions.hpp"
#include "variable.hpp"



//




void make_estimable(variable& par) {
    variable::tape_g.independent_variables.push_back(par.info);
}

const variable parameter() {
    variable v;
    variable::tape_g.independent_variables.push_back(v.info);
    v.info->independent = true;
    return v;
}

variable make_variable() {
    variable v;
    return v;
}

variable_vector make_vector(int size) {
    variable_vector v(size);
    return v;
}

variable_matrix make_matrix(int rows, int cols) {
    variable_matrix m(rows, cols);
    return m;
}

void show(variable v) {
    std::cout << v.value() << std::endl;
}

Rcpp::NumericVector gradient(Rcpp::NumericVector x) {
    Rcpp::NumericVector ret(variable::tape_g.independent_variables.size());
    if (x.size() != ret.size()) {
        std::cout << "Error in gradient function: x vector size not equal to independent variable size.\n";
    } else {
        for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
            variable::tape_g.independent_variables[i]->value = x[i];
        }
        variable::tape_g.forward();
        variable::tape_g.reverse();
        for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
            ret[i] = variable::tape_g.gradient[variable::tape_g.independent_variables[i]->id];
        }
    }
    return ret;
}

double gradient_maxgc(const std::vector<double>& x, std::vector<double>& gradient, double& maxgc) {

    maxgc = std::numeric_limits<double>::min();
    if (x.size() != gradient.size()) {
        std::cout << "Error in gradient function: x vector size not equal to independent variable size.\n";
    } else {
        for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
            variable::tape_g.independent_variables[i]->update_value(x[i]);
        }
        variable::tape_g.forward();
        variable::tape_g.reverse();

        for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
            gradient[i] = variable::tape_g.gradient[variable::tape_g.independent_variables[i]->id];

            if (std::fabs(gradient[i]) > maxgc) {
                maxgc = std::fabs(gradient[i]);
            }
        }
    }
    return variable::tape_g.stack[variable::tape_g.stack.size() - 1]->dependent->value;

}

double gradient_maxgc(const std::valarray<double>& x, std::valarray<double>& gradient, double& maxgc) {

    maxgc = -1.0 * std::numeric_limits<double>::min();

    if (x.size() != gradient.size()) {
        std::cout << "Error in gradient function: x vector size not equal to independent variable size.\n";
    } else {

        for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
            variable::tape_g.independent_variables[i]->update_value(x[i]);
        }

        variable::tape_g.forward();
        variable::tape_g.reverse();

        for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
            gradient[i] = variable::tape_g.gradient[variable::tape_g.independent_variables[i]->id];

            if (std::fabs(gradient[i]) > maxgc) {
                maxgc = std::fabs(gradient[i]);
            }
        }
    }
    return variable::tape_g.stack[variable::tape_g.stack.size() - 1]->dependent->value;

}

double evaluate(Rcpp::NumericVector x) {
    if (x.size() != variable::tape_g.independent_variables.size()) {
        std::cout << "Error in call to \"function\": x vector size not equal to independent variable size.\n";
        return 0.0;
    } else {

        for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
            variable::tape_g.independent_variables[i]->value = x[i];
        }

        variable::tape_g.forward();

    }
    return variable::tape_g.stack[variable::tape_g.stack.size() - 1]->dependent->value;
}

double internal_evaluate(std::vector<double>& x) {

    if (x.size() != variable::tape_g.independent_variables.size()) {
        std::cout << "Error in call to \"function\": x vector size not equal to independent variable size.\n";
        return 0.0;
    } else {
        for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
            variable::tape_g.independent_variables[i]->update_value(x[i]);
        }

        variable::tape_g.forward();

    }
    return variable::tape_g.stack[variable::tape_g.stack.size() - 1]->dependent->value;
}

double internal_evaluate(std::valarray<double>& x) {

    if (x.size() != variable::tape_g.independent_variables.size()) {
        std::cout << "Error in call to \"function\": x vector size not equal to independent variable size.\n";
        return 0.0;
    } else {
        for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
            variable::tape_g.independent_variables[i]->update_value(x[i]);
        }

        variable::tape_g.forward();

    }
    return variable::tape_g.stack[variable::tape_g.stack.size() - 1]->dependent->value;
}

Rcpp::NumericVector get_values() {
    Rcpp::NumericVector ret(variable::tape_g.independent_variables.size());
    for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
        ret[i] = variable::tape_g.independent_variables[i]->value;
    }
    return ret;
}

void clear() {
    variable::tape_g.gradient.clear();
    variable::tape_g.independent_variables.clear();
    variable::tape_g.stack.clear();
    variable::tape_g.recording = false;
    variable_info::id_g = 0;
}

void set_recording(bool record) {
    variable::tape_g.recording = record;
}

bool is_recording() {
    return variable::tape_g.recording;
}

void print() {

}

const double norm(std::valarray<double> &v) {

    double ret = 0.0;
    unsigned int i;
    for (i = 0; i < v.size(); i++) {

        ret += v[i] * v[i];

    }
    return std::sqrt(ret);
}

/**
 * Compute the dot product of two vectors.
 * @param a
 * @param b
 * @return 
 */
const double Dot(const std::valarray<double> &a, const std::valarray<double> &b) {
    double ret = 0;
    for (size_t i = 0; i < a.size(); i++) {

        ret += a[i] * b[i];
    }
    return ret;
}

/**
 * returns the a column of a matrix as a std::valarray.
 * @param matrix
 * @param column
 * @return 
 */
const std::valarray<double> Column(std::valarray<std::valarray<double> > &matrix, size_t column, size_t length) {

    std::valarray<double> ret(length);

    for (int i = 0; i < ret.size(); i++) {

        ret[i] = matrix[i][column];
    }
    return ret;
}

bool line_search(
        double& fx,
        double& function_value,
        std::valarray<double>& x,
        std::valarray<double>& best,
        std::valarray<double>& z,
        std::valarray<double>& gradient,
        std::valarray<double>& wg,
        double& maxgc, int& i,
        int& max_iterations,
        bool inner = true) {


    //    int max_iterations = 1000;
    double tolerance = 1e-4;
    int max_line_searches = 500;
    double descent = 0;

    int nops = variable::tape_g.independent_variables.size();

    std::valarray<double> ng(nops);

    for (size_t j = 0; j < nops; j++) {
        descent += z[j] * wg[j];
    }//end for

    double norm_g = norm(gradient);
    double relative_tolerance = tolerance * std::max<double > ((1.0), norm_g);

    descent *= -1.0; // * Dot(z, g);
    if ((descent > (-0.00000001) * relative_tolerance /* tolerance relative_tolerance*/)) {
        z = wg + .001;
        if (!inner) {
            max_iterations -= i;
            i = 0;
        }
        descent = -1.0 * Dot(z, wg);
    }//end if

    double step = i ? 1.0 : (1.0 / norm_g);

    if (step != step || step == 0.0) {
        step = 1.0;
    }

    bool down = false;

    int ls;




    for (int j = 0; j < nops; j++) {
        best[j] = variable::tape_g.independent_variables[j]->internal_value();
    }

    //            atl::Variable<T> fx;

    for (ls = 0; ls < max_line_searches; ++ls) {


        //        if ((ls % 10) == 0) {
        //            std::cout << "Line search iteration " << ls << "\n";
        //            std::cout << "f = " << fx << "\n";
        //        }

        // Tentative solution, gradient and loss
        std::valarray<double> nx = x - step * z;

        for (size_t j = 0; j < nops; j++) {

            if (nx[j] != nx[j]) {

                //                std::cout<<j<< " "<<ls<<" "<<x[j]<< " "<<step <<" " <<z[j]<<"\n";

            }
            variable::tape_g.independent_variables[j]->update_value(nx[j]);
        }

        //        //line_search:
        //        atl::Variable<T>::SetRecording(false);
        //        if (inner) {
        //            this->CallInnerObjectiveFunction(fx);
        //        } else {
        //            this->CallObjectiveFunction(fx);
        //            
        //        }

        fx = internal_evaluate(nx);

        //                atl::Variable<T>::tape.Reset();
        if (fx <= function_value + tolerance * (10e-4) * step * descent) { // First Wolfe condition

            for (size_t j = 0; j < nops; j++) {
                best[j] = variable::tape_g.independent_variables[j]->value;
            }




            fx = gradient_maxgc(nx, ng, maxgc);

            //            if ((this->outer_iteration % this->print_interval) == 0) {
            //                gradient = ng;
            //                std::cout << io::GREEN << "Line Search Update.\n" << io::DEFAULT;
            //                this->Print();
            //            }

            //            atl::Variable<T>::tape.Reset();
            if (down || (-1.0 * Dot(z, ng) >= 0.9 * descent)) { // Second Wolfe condition
                x = nx;
                gradient = ng;
                function_value = fx;
                return true;
            } else {

                step *= 10.0; //2.0; //10.0;
            }
        } else {
            step /= 10.0; //*= .5; ///
            down = true;
        }
    }

    for (size_t j = 0; j < nops; j++) {
        variable::tape_g.independent_variables[j]->update_value(best[j]);
    }

    return false;

}

Rcpp::List lbfgs(Rcpp::Nullable<Rcpp::List> control = R_NilValue) {

    std::chrono::time_point<std::chrono::system_clock> start, end;
    start = std::chrono::system_clock::now();
    int max_history = 200;
    int max_iterations = 1000;
    double tolerance = 1e-4;
    double function_value;
    double maxgc;
    bool verbose = true;
    int iprint = 10;
    bool converged = false;
    Rcpp::List results;


    Rcpp::List ctrl(control);
    if (ctrl.containsElementNamed("max_iterations")) {
        double maxi = ctrl["max_iterations"];
        if (maxi != 0) {
            max_iterations = maxi;
        }
    }

    if (ctrl.containsElementNamed("tolerance")) {
        double tol = ctrl["tolerance"];
        tolerance = tol;
    }

    if (ctrl.containsElementNamed("iprint")) {
        int print_interval = ctrl["iprint"];
        if (print_interval != 0) {
            iprint = print_interval;
        }
    }
    if (ctrl.containsElementNamed("verbose")) {
        bool is_verbose = ctrl["verbose"];
        if (!is_verbose) {
            verbose = is_verbose;
        }
    }
    //    it = ctrl.
    //    if (control.isNotNull()) {
    //        //        it = ctrl["gtol"];
    //        //        if (it != ctrl.end()) {
    //        //            tolerance = (*it).
    //        //        }
    //    }

    int nops = variable::tape_g.independent_variables.size();

    std::valarray<double> x, best, gradient;

    x.resize(nops);
    best.resize(nops);
    gradient.resize(nops);

    for (int i = 0; i < nops; i++) {
        if (variable::tape_g.independent_variables[i]->is_bound) {
            x[i] = variable::tape_g.independent_variables[i]->internal_value();
        } else {
            x[i] = variable::tape_g.independent_variables[i]->value;
        }
        gradient[i] = 0;
    }
    //
    //
    std::valarray<double> wg(nops);
    std::valarray<double> nwg(nops);
    std::valarray<double> ng(nops);
    Rcpp::NumericVector rgrad(nops);
    Rcpp::NumericVector rx(nops);

    //initial evaluation
    double fx(0.0);
    fx = internal_evaluate(x);
    function_value = fx;
    //
    //Historical evaluations
    std::valarray<double> px(nops);
    std::valarray<double> pg(nops);
    std::valarray<std::valarray<double> > dxs(std::valarray<double > (max_history), nops);
    std::valarray<std::valarray<double> > dgs(std::valarray<double > (max_history), nops);
    //search direction
    std::valarray<double> z(nops);


    fx = gradient_maxgc(x, gradient, maxgc);





    std::valarray<double> p(max_history);
    std::valarray<double> a(max_history);
    int no_progress_count = 0;
    int i;
    for (int iteration = 0; iteration < max_iterations; iteration++) {
        i = iteration;

        for (int j = 0; j < nops; j++) {
            wg[j] = variable::tape_g.independent_variables[j]->
                    get_scaled_gradient(variable::tape_g.independent_variables[j]->internal_value()) * gradient[j];
            //                    this->parameters_m[j]->GetScaledGradient(
            //                    this->parameters_m[j]->GetInternalValue()) * this->gradient[j];
        }

        if (((i % iprint) == 0) && verbose) {
            std::cout << "Iteration " << i << "\n";
            std::cout << "f = " << fx << ", maxgc = " << maxgc << "\n";
        }


        if (maxgc < tolerance) {
            end = std::chrono::system_clock::now();
            std::chrono::duration<double> elapsed_seconds = end - start;
            for (size_t j = 0; j < nops; j++) {
                rgrad[j] = gradient[j];
                rx[j] = variable::tape_g.independent_variables[j]->value;
            }
            results["converged"] = true;
            results["iterations"] = iteration;
            results["runtime (seconds)"] = elapsed_seconds.count();
            results["function value"] = fx;
            results["max gradient component"] = maxgc;
            results["gradient"] = rgrad;
            results["parameter values"] = rx;

            return results;
        }

        z = wg;

        if (i > 0 && max_history > 0) {

            size_t h = std::min<size_t > (i, max_history);
            size_t end = (i - 1) % h;

            //update histories
            for (size_t r = 0; r < nops; r++) {
                dxs[r][end] = variable::tape_g.independent_variables[r]->internal_value() - px[r];
                dgs[r][end] = wg[r] - pg[r];
            }



            for (size_t j = 0; j < h; ++j) {
                const size_t k = (end - j + h) % h;
                p[k] = 1.0 / Dot(Column(dxs, k, nops), Column(dgs, k, nops));

                a[k] = p[k] * Dot(Column(dxs, k, nops), z);
                z -= a[k] * Column(dgs, k, nops);
            }
            // Scaling of initial Hessian (identity matrix)
            z *= Dot(Column(dxs, end, nops), Column(dgs, end, nops)) / Dot(Column(dgs, end, nops), Column(dgs, end, nops));

            for (size_t j = 0; j < h; ++j) {
                const size_t k = (end + j + 1) % h;
                const double b = p[k] * Dot(Column(dgs, k, nops), z);
                z += Column(dxs, k, nops) * (a[k] - b);
            }

        }//end if(i>0)

        for (size_t j = 0; j < nops; j++) {
            px[j] = variable::tape_g.independent_variables[j]->internal_value();
            x[j] = px[j];
            pg[j] = wg[j];


        }//end for


        
        
        
        double fv = function_value;
        if (!line_search(
                fx,
                function_value,
                x,
                best,
                z,
                gradient,
                wg,
                maxgc,
                iteration,
                max_iterations,
                false)) {
            std::cout << "Max line searches\n\n";
            end = std::chrono::system_clock::now();
            std::chrono::duration<double> elapsed_seconds = end - start;
            for (size_t j = 0; j < nops; j++) {
                rgrad[j] = gradient[j];
                rx[j] = variable::tape_g.independent_variables[j]->value;
            }
            
            if(maxgc<= tolerance){
                converged = true;
            }
            
            results["converged"] = converged;
            results["iterations"] = iteration;
            results["runtime (seconds)"] = elapsed_seconds.count();
            results["function value"] = fx;
            results["max gradient component"] = maxgc;
            results["gradient"] = rgrad;
            results["parameter values"] = rx;

            return results;

        }
        
        if ((fv - function_value) == 0.0 && no_progress_count == 15) {
            std::cout << "Not progressing...bailing out!\n";
            end = std::chrono::system_clock::now();
            std::chrono::duration<double> elapsed_seconds = end - start;
            for (size_t j = 0; j < nops; j++) {
                rgrad[j] = gradient[j];
                rx[j] = variable::tape_g.independent_variables[j]->value;
            }
            
            
            if(maxgc<= tolerance){
                converged = true;
            }
            results["converged"] = converged;
            results["iterations"] = iteration;
            results["runtime (seconds)"] = elapsed_seconds.count();
            results["function value"] = fx;
            results["max gradient component"] = maxgc;
            results["gradient"] = rgrad;
            results["parameter values"] = rx;
            return results;
        } else {
            no_progress_count++;
        }

    }

    end = std::chrono::system_clock::now();
    std::chrono::duration<double> elapsed_seconds = end - start;
    for (size_t j = 0; j < nops; j++) {
        rgrad[j] = gradient[j];
        rx[j] = variable::tape_g.independent_variables[j]->value;
    }
    
    if(maxgc<= tolerance){
        converged = true;
    }

    results["converged"] = converged;
    results["iterations"] = i;
    results["runtime (seconds)"] = elapsed_seconds.count();
    results["function value"] = fx;
    results["max gradient component"] = maxgc;
    results["gradient"] = rgrad;
    results["parameter values"] = rx;

    std::cout << "Max iterations!\n\n";

    return results;
}

RCPP_EXPOSED_CLASS(variable)

RCPP_MODULE(adinr) {
    using namespace Rcpp;
    class_<variable >("variable")
            .constructor()
            .constructor<double>()
            .constructor<variable&>()
            .method("value", &variable::value)
            .method("set_value", &variable::set_value)
            .method("bounds", &variable::bounds);
    class_<variable_vector >("variable_vector")
            .constructor()
            .constructor<int>()
            .method("resize", &variable_vector::resize)
            .method("at", &variable_vector::at);
    class_<variable_matrix >("variable_matrix")
            .constructor()
            .constructor<int, int>()
            .method("resize", &variable_matrix::resize)
            .method("at", &variable_matrix::at);
    function("acos", &ad_acos);
    function("asin", &ad_asin);
    function("atan", &ad_atan);
    function("cos", &ad_cos);
    function("sin", &ad_sin);
    function("tan", &ad_tan);
    function("cosh", &ad_cosh);
    function("sinh", &ad_sinh);
    function("tanh", &ad_tanh);
    function("exp", &ad_exp);
    function("log", &ad_log);
    function("log10", &ad_log10);
    function("addvv", &addvv);
    function("addvd", &addvd);
    function("adddv", &adddv);
    function("subvv", &subvv);
    function("subvd", &subvd);
    function("subdv", &subdv);
    function("multvv", &multvv);
    function("multvd", &multvd);
    function("multdv", &multdv);
    function("divvv", &divvv);
    function("divvd", &divvd);
    function("divdv", &divdv);
    function("powvv", &powvv);
    function("powvd", &powvd);
    function("powdv", &powdv);
    function("make_estimable", &make_estimable, "adds a variable to the list of independent variables to be estimated");
    function("parameter", &parameter, "creates a variable and adds it to the list of estimable parameters");
    function("variable", &make_variable, "returns a variable");
    //    function("make_vector", &make_vector, "returns a vector of variables");
    //    function("make_matrix", &make_matrix, "returns a matrix of variables");
    function("evaluate", &evaluate, "evaluates the objective function at the given x values");
    function("gradient", &gradient, "evaluates the gradient at the given x values");
    function("parameter_values", &get_values, "returns a vector of parameter values");
    function("clear", &clear, "clears the tape of entries and independent variables");
    function("minimize", &lbfgs, "minimizes the objective function using l-bfgs");
    function("set_recording", &set_recording);
    function("is_recording", &is_recording);
    function("show", &show);
}

bool isVariable(SEXP s)
{
  SEXP klass;
  int i;
  if (OBJECT(s)) {
    klass = Rf_getAttrib(s, R_ClassSymbol);
    for (i = 0; i <  Rf_length(klass); i++)
      if (!strcmp(CHAR(STRING_ELT(klass, i)), "Rcpp_variable")) return TRUE;
  }
  return FALSE;
}


/**
 * Top level functions.
 */
  
  // [[Rcpp::export]]
void MakeEstimable(SEXP v) {
    if(isVariable(v)){
    variable::tape_g.independent_variables.push_back(Rcpp::as<variable>(v).info);
      Rcpp::as<variable>(v).info->independent = true;
    }else{
      Rcpp::stop("Unknown argument type for MakeEstimable function.");
    }
  }

// [[Rcpp::export]]
const SEXP Variable(){
  variable v;
  return Rcpp::wrap(v);
}

// [[Rcpp::export]]
const SEXP Parameter(){
  variable v;
  variable::tape_g.independent_variables.push_back(v.info);
  v.info->independent = true;
    return Rcpp::wrap(v);
}

// [[Rcpp::export]]
SEXP GetValues() {
  Rcpp::NumericVector ret(variable::tape_g.independent_variables.size());
  for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
    ret[i] = variable::tape_g.independent_variables[i]->value;
  }
  return Rcpp::wrap(ret);
}

// [[Rcpp::export]]
void Show(SEXP v) {
  if(isVariable(v)){
    variable V = Rcpp::as<variable>(v);
    Rcpp::Rcout << V.value() << std::endl;
  }
}

// [[Rcpp::export]]
const SEXP Gradient(Rcpp::NumericVector x){
  Rcpp::NumericVector ret(variable::tape_g.independent_variables.size());
  if (x.size() != ret.size()) {
    std::cout << "Error in gradient function: x vector size not equal to independent variable size.\n";
  } else {
    for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
      variable::tape_g.independent_variables[i]->value = x[i];
    }
    variable::tape_g.forward();
    variable::tape_g.reverse();
    for (int i = 0; i < variable::tape_g.independent_variables.size(); i++) {
      ret[i] = variable::tape_g.gradient[variable::tape_g.independent_variables[i]->id];
    }
  }
  
  return Rcpp::wrap(ret);
}

// [[Rcpp::export]]
void Clear() {
  variable::tape_g.gradient.clear();
  variable::tape_g.independent_variables.clear();
  variable::tape_g.stack.clear();
  variable::tape_g.recording = false;
  variable_info::id_g = 0;
}

// [[Rcpp::export]]
void SetRecording(bool record){
  variable::tape_g.recording = record;
}

// [[Rcpp::export]]
Rcpp::List Minimize(Rcpp::Nullable<Rcpp::List> control = R_NilValue){
  return lbfgs(control);
}

// [[Rcpp::export]]
const SEXP ACos(const SEXP& x){
  if(isVariable(x)){
    variable v = ad_acos(Rcpp::as<variable>(x));
    return Rcpp::wrap(v);
  }
  Rcpp::stop("Unknown argument type for ACos function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP ASin(SEXP x){
  if(isVariable(x)){
    return Rcpp::wrap(ad_asin(Rcpp::as<variable>(x)));
  }
  Rcpp::stop("Unknown argument type for ASin function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP ATan(SEXP x){
  if(isVariable(x)){
    return Rcpp::wrap(ad_atan(Rcpp::as<variable>(x)));
  }
  Rcpp::stop("Unknown argument type for ATan function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Cos(SEXP x){
  if(isVariable(x)){
    return Rcpp::wrap(ad_cos(Rcpp::as<variable>(x)));
  }
  Rcpp::stop("Unknown argument type for Cos function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Cosh(SEXP x){
  if(isVariable(x)){
    return Rcpp::wrap(ad_cosh(Rcpp::as<variable>(x)));
  }
  Rcpp::stop("Unknown argument type for Cosh function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Sin(SEXP x){
  if(isVariable(x)){
    return Rcpp::wrap(ad_sin(Rcpp::as<variable>(x)));
  }
  Rcpp::stop("Unknown argument type for Sin function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Sinh(SEXP x){
  if(isVariable(x)){
    return Rcpp::wrap(ad_sinh(Rcpp::as<variable>(x)));
  }
  Rcpp::stop("Unknown argument type for Sinh function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Tan(SEXP x){
  if(isVariable(x)){
    return Rcpp::wrap(ad_tan(Rcpp::as<variable>(x)));
  }
  Rcpp::stop("Unknown argument type for Tan function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Tanh(SEXP x){
  if(isVariable(x)){
    return Rcpp::wrap(ad_tanh(Rcpp::as<variable>(x)));
  }
  Rcpp::stop("Unknown argument type for Tanh function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Exp(SEXP x){
  if(isVariable(x)){
    return Rcpp::wrap(ad_exp(Rcpp::as<variable>(x)));
  }
  Rcpp::stop("Unknown argument type for Exp function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Log(SEXP x){
  if(isVariable(x)){
    return Rcpp::wrap(ad_log(Rcpp::as<variable>(x)));
  }
  Rcpp::stop("Unknown argument type for Log function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Log10(SEXP x){
  if(isVariable(x)){
    return Rcpp::wrap(ad_log10(Rcpp::as<variable>(x)));
  }
  Rcpp::stop("Unknown argument type for Log10 function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Pow( SEXP a,  SEXP b){
  if(isVariable(a) && isVariable(b)){
    return Rcpp::wrap(powvv(Rcpp::as<variable>(a),Rcpp::as<variable>(b)));
  }else if (isVariable(a) && Rf_isNumeric(b)){
    return Rcpp::wrap(powvd(Rcpp::as<variable>(a),Rcpp::as<double>(b)));
  }else if(Rf_isNumeric(a) && isVariable(b)){
    return Rcpp::wrap(powdv(Rcpp::as<double>(a),Rcpp::as<variable>(b)));
  }
  Rcpp::stop("Unknown argument type for Pow function.");
  return NULL;
}


// [[Rcpp::export]]
const SEXP Add( SEXP a,  SEXP b){
  if(isVariable(a) && isVariable(b)){
    return Rcpp::wrap(addvv(Rcpp::as<variable>(a),Rcpp::as<variable>(b)));
  }else if (isVariable(a) && Rf_isNumeric(b)){
    return Rcpp::wrap(addvd(Rcpp::as<variable>(a),Rcpp::as<double>(b)));
  }else if(Rf_isNumeric(a) && isVariable(b)){
    return Rcpp::wrap(adddv(Rcpp::as<double>(a),Rcpp::as<variable>(b)));
  }
  Rcpp::stop("Unknown argument type for Pow function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Sub( SEXP a,  SEXP b){
  if(isVariable(a) && isVariable(b)){
    return Rcpp::wrap(subvv(Rcpp::as<variable>(a),Rcpp::as<variable>(b)));
  }else if (isVariable(a) && Rf_isNumeric(b)){
    return Rcpp::wrap(subvd(Rcpp::as<variable>(a),Rcpp::as<double>(b)));
  }else if(Rf_isNumeric(a) && isVariable(b)){
    return Rcpp::wrap(subdv(Rcpp::as<double>(a),Rcpp::as<variable>(b)));
  }
  Rcpp::stop("Unknown argument type for Pow function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Mult( SEXP a,  SEXP b){
  if(isVariable(a) && isVariable(b)){
    return Rcpp::wrap(multvv(Rcpp::as<variable>(a),Rcpp::as<variable>(b)));
  }else if (isVariable(a) && Rf_isNumeric(b)){
    return Rcpp::wrap(multvd(Rcpp::as<variable>(a),Rcpp::as<double>(b)));
  }else if(Rf_isNumeric(a) && isVariable(b)){
    return Rcpp::wrap(multdv(Rcpp::as<double>(a),Rcpp::as<variable>(b)));
  }
  Rcpp::stop("Unknown argument type for Pow function.");
  return NULL;
}

// [[Rcpp::export]]
const SEXP Div( SEXP a,  SEXP b){
  if(isVariable(a) && isVariable(b)){
    return Rcpp::wrap(divvv(Rcpp::as<variable>(a),Rcpp::as<variable>(b)));
  }else if (isVariable(a) && Rf_isNumeric(b)){
    return Rcpp::wrap(divvd(Rcpp::as<variable>(a),Rcpp::as<double>(b)));
  }else if(Rf_isNumeric(a) && isVariable(b)){
    return Rcpp::wrap(divdv(Rcpp::as<double>(a),Rcpp::as<variable>(b)));
  }
  Rcpp::stop("Unknown argument type for Pow function.");
  return NULL;
}

#endif /* RINTERFACE_HPP */

