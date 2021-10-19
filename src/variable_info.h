/*
 * File:   variable_info.hpp
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
#ifndef VARIABLE_INFO_H
#define VARIABLE_INFO_H

struct variable_info {
    static size_t id_g;
    size_t id;
    double value;
    double minb;
    double maxb;
    bool is_bound = false;

    variable_info() :
    id(variable_info::id_g++), value(0) {

    }

    double internal_value() {
        return this->value;
    }

    double get_scaled_gradient(double g) {
        return g;

    }
    
    void update_value(double v) {
        this->value = v;
    }
};

//    template<typename T>
size_t variable_info::id_g = 0;



#endif /* VARIABLE_INFO_H */

