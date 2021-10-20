/*
 * File:   operators.hpp
 *
 * Author: Matthew Supernaw
 * National Oceanic and Atmospheric Administration
 * National Marine Fisheries Service
 * Sustainable Fisheries Division
 * Email: matthew.supernaw@noaa.gov
 *
 *
 *
 * This File is part of the NOAA, National Marine Fisheries Service
 * Automatic Differntiation in R project.
 *
 * This software is a "United States Government Work" under the terms of the
 * United States Copyright Act.  It was written as part of the author's official
 * duties as a United States Government employee and thus cannot be copyrighted.
 * This software is freely available to the public for use. The National Oceanic
 * And Atmospheric Administration and the U.S. Government have not placed any
 * restriction on its use or reproduction.  Although all reasonable efforts have
 * been taken to ensure the accuracy and reliability of the software and data,
 * the National Oceanic And Atmospheric Administration and the U.S. Government
 * do not and cannot warrant the performance or results that may be obtained by
 * using this  software or data. The National Oceanic And Atmospheric
 * Administration and the U.S. Government disclaim all warranties, express or
 * implied, including warranties of performance, merchantability or fitness
 * for any particular purpose.
 *
 * Please cite the author(s) in any work or product based on this material.
 *
 */
#ifndef OPERAdoubleORS_HPP
#define OPERAdoubleORS_HPP

#include <cmath>

#include <set>
#include <unordered_map>
#include <memory>
#include "variable_info.h"
//#include "variable.hpp"
//#include "tape.hpp"
#include <memory>
//#include "variable.hpp"


#ifndef AD_LOG10
#define AD_LOG10 2.30258509299404590109361379290930926799774169921875
#endif






    struct tape;


    struct ad_operator {
        std::shared_ptr<variable_info > dependent;
        virtual double value() = 0;
        virtual void update() = 0; //used for forward sweep
        virtual void first_order(std::vector<double>& derivatives) = 0;
    };

    struct unary_operator : public ad_operator {
        std::shared_ptr<variable_info > x;

        virtual double value() {
            return 0;
        }

        virtual void update() {

        }

        virtual void first_order(std::vector<double>& derivatives) {

        }


    };

    struct acos_operator : unary_operator {

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::acos(this->x->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            double adjoint = -1.0 / std::sqrt(1 - std::pow(this->x->value, 2.0));
            derivatives[this->x->id] += w*adjoint;
        }
    };


    struct asin_operator : unary_operator {

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::acos(this->x->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            double adjoint = 1.0 / std::sqrt(1 - std::pow(this->x->value, 2.0));
            derivatives[this->x->id] += w*adjoint;
        }
    };


    struct atan_operator : unary_operator {

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::atan(this->x->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            double adjoint = 1.0 / (std::pow(this->x->value, 2.0) + 1.0);
            derivatives[this->x->id] += w*adjoint;
        }
    };


    struct cos_operator : unary_operator {

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::cos(this->x->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            double adjoint = -1.0 * std::sin(this->x->value);
            derivatives[this->x->id] += w*adjoint;
        }
    };



    struct cosh_operator : unary_operator {

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::cosh(this->x->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            double adjoint = std::sinh(this->x->value);
            derivatives[this->x->id] += w*adjoint;
        }
    };

    struct sin_operator : unary_operator {

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::sin(this->x->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            double adjoint = std::cos(this->x->value);
            derivatives[this->x->id] += w*adjoint;
        }
    };



    struct sinh_operator : unary_operator {

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::sinh(this->x->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            double adjoint = std::cosh(this->x->value);
            derivatives[this->x->id] += w*adjoint;
        }
    };


    struct tan_operator : unary_operator {

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::tan(this->x->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            double adjoint = std::pow(1.0 / std::cos(this->x->value), 2.0);
            derivatives[this->x->id] += w*adjoint;
        }
    };

 
    struct tanh_operator : unary_operator {

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::tanh(this->x->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            double adjoint = std::pow(1.0 / std::cosh(this->x->value), 2.0);
            derivatives[this->x->id] += w*adjoint;
        }
    };

    struct exp_operator : unary_operator {

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::tanh(this->x->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            double adjoint = std::exp(this->x->value);
            derivatives[this->x->id] += w*adjoint;
        }
    };


    struct log_operator : unary_operator {

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::log(this->x->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            double adjoint = 1.0 / this->x->value;
            derivatives[this->x->id] += w*adjoint;
        }
    };



    struct log10_operator : unary_operator {

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::log10(this->x->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            double adjoint = 1.0 / (AD_LOG10 * this->x->value);
            derivatives[this->x->id] += w*adjoint;
        }
    };



    struct binary_operator : public ad_operator {
        std::shared_ptr<variable_info > left;
        std::shared_ptr<variable_info > right;

        virtual double value() {
            return 1;
        }

        virtual void update() {

        }

        virtual void first_order(std::vector<double>& derivatives) {

        }
    };

    struct addvv_operator : public ad_operator {
        std::shared_ptr<variable_info > left;
        std::shared_ptr<variable_info > right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = this->left->value + this->right->value;
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->left->id] += w;
            derivatives[this->right->id] += w;
        }
    };


    struct addvd_operator : public ad_operator {
        std::shared_ptr<variable_info > left;
        double right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = this->left->value + this->right;
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->left->id] += w;
        }
    };



    struct adddv_operator : public ad_operator {
        double left;
        std::shared_ptr<variable_info > right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = this->left + this->right->value;
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->right->id] += w;
        }
    };


    struct subvv_operator : public ad_operator {
        std::shared_ptr<variable_info > left;
        std::shared_ptr<variable_info > right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = this->left->value - this->right->value;
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->left->id] += w;
            derivatives[this->right->id] += -1.0 * w;
        }
    };


    struct subvd_operator : public ad_operator {
        std::shared_ptr<variable_info > left;
        double right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = this->left->value - this->right;
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->left->id] += w;
        }
    };

   

    struct subdv_operator : public ad_operator {
        double left;
        std::shared_ptr<variable_info > right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = this->left - this->right->value;
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->right->id] += -1.0 * w;
        }
    };


    struct multvv_operator : public ad_operator {
        std::shared_ptr<variable_info > left;
        std::shared_ptr<variable_info > right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = this->left->value * this->right->value;
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->left->id] += w * this->right->value;
            derivatives[this->right->id] += w * this->left->value;
        }
    };



    struct multvd_operator : public ad_operator {
        std::shared_ptr<variable_info > left;
        double right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = this->left->value * this->right;
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->left->id] += w * this->right;
        }
    };

    struct multdv_operator : public ad_operator {
        double left;
        std::shared_ptr<variable_info > right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = this->left * this->right->value;
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->right->id] += w * this->left;
        }
    };



    struct divvv_operator : public ad_operator {
        std::shared_ptr<variable_info > left;
        std::shared_ptr<variable_info > right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = this->left->value / this->right->value;
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->left->id] += w * (1.0 / this->right->value);
            derivatives[this->right->id] += w * (-1.0 * this->left->value / (this->right->value * this->right->value));
        }
    };

    struct divvd_operator : public ad_operator {
        std::shared_ptr<variable_info > left;
        double right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = this->left->value / this->right;
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->left->id] += w * (1.0 / this->right);
        }
    };



    struct divdv_operator : public ad_operator {
        double left;
        std::shared_ptr<variable_info > right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = this->left / this->right->value;
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->right->id] += w * (-1.0 * this->left / (this->right->value * this->right->value));

        }
    };


    struct powvv_operator : public ad_operator {
        std::shared_ptr<variable_info > left;
        std::shared_ptr<variable_info > right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::pow(this->left->value, this->right->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->left->id] += w * std::pow((this->left->value * this->right->value), this->right->value - 1.0);
            derivatives[this->right->id] += w * (std::pow(this->left->value, this->right->value) * std::log(this->left->value));
        }
    };

  

    struct powvd_operator : public ad_operator {
        std::shared_ptr<variable_info > left;
        double right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::pow(this->left->value, this->right);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->left->id] += w * std::pow((this->left->value * this->right), this->right - 1.0);
        }
    };

    struct powdv_operator : public ad_operator {
        double left;
        std::shared_ptr<variable_info > right;

        virtual double value() {
            return this->dependent->value;
        }

        virtual void update() {
            this->dependent->value = std::pow(this->left, this->right->value);
        }

        virtual void first_order(std::vector<double>& derivatives) {
            double w = derivatives[this->dependent->id];
            derivatives[this->right->id] += w * (std::pow(this->left, this->right->value) * std::log(this->left));

        }
    };








#endif /* OPS_HPP */

