"""
THIS IS A SCRIPT TO DEBUG METHODS USED IN PRTOOLS INCLUDING METHODS CONTAINED IN PRTOOLS.PY, UCI.PY AND DATASET.PY

Testing ...
    From Dataset Related, Distribution, Generation, 
        extractClass - Implemented | Working
        genlab - Implemented | Working
        getlabels - Not Implemented
        getlablist - Not Implemented
        seldat - Implemented | Working
        !gendatb - Implemented | Not Working
             *Goncalo
        gendatc - Implemented | Not Working
        gendatd - Implemented | Not Working
        gendath - Implemented | Not Working
        gendatdd - Implemented | Not Working
        setfeatlab - Not Implemented
        gendatk - Implemented | Not Working
        gendatp - Implemented | Not Working
        gendatgauss - Implemented | Not Working
        gauss - Implemented | Not Working
        gendats - Implemented | Not Working
        gendat - Implemented | Working
        getlab - Not Implemented
        getprior - Not Implemented
        setprior - Not Implemented
        gettargets - Not Implemented
        circles3d - Not Implemented
        lines5d - Implemented | Not Working
        laplace - Implemented | Not Working
        genregres - Not Implemented
        preig - Implemented | Not Working
        getsize - Implemented | Working
        setname - Implemented | Working
        addlablist - Not Implemented
        nbayesc - Implemented | Working 
        setlabtype - Not Implemented
        curlablist - Not Implemented
        setlablist - Not Implemented
        getdata - Implemented | Working
        genclass - Implemented | Not Working
        setlabtype - Not Implemented
        gauss_multi_class - Implemented | Working
    From ploting:
		plotf - Implemented | Not Working
		scatterd - Implemented | Working
        scatterdui - Implemented | Working
        plotm - Not Implemented
        plote - Not Implemented
        plotc - Not Implemented
        scatterr - Implemented | Not Working
        hist2 - Not Implemented
        roc_n_plot - Implemented | Working
        mean_square_fitting - NEED A PROPER Y PREDICTED TO BE ABLE TO TEST THIS
        mean_square - NEED A PROPER Y PREDICTED TO BE ABLE TO TEST THIS
    From Generic prtools
        testc - Implemented | Working
        prcrossval - Implemented | Working
        distm - Implemented | Working
        proxm - Implemented | Not Working
        cleval - Implemented | Working
        clevalf - Implemented | Working
    From Supervised methods
        derls -  - Implemented | Not Working
        rbnc - Implemented | Working (initialization)
        multilayer_classifier- Implemented | Working (initialization)
        parzenml_vector - Implemented | Not Working
        parzenml_scalar - Implemented | Not Working
        derlc - Implemented | Not Working
        qdc - Implemented | Working
        loglc - Implemented | Working (initialization)
        parzenc - Implemented | Working (initialization)
        knnc - Implemented | Working (initialization)
        ldc - Implemented | Working (initialization)
        fisherc - Implemented | Working (initialization)
        nmc - Implemented | Working (initialization)
        dectreec - Implemented | Working (initialization)
        lmnc - Not Implemented
        svc - Implemented | Working (initialization)
        svc_kernel - Not Implemented
        pairwise_km - Not Implemented
        combine_kernels - Not Implemented
        parsc - Implemented | Working
        baggingc - Implemented | Working (initialization)
        stumpc - Implemented | Not Working
        weakc - Implemented | Working
        adaboostc - Implemented | Working
        linearr - Implemented | Working
        pamc - Not Implemented
    From Unsupervised methods
        pcam - Implemented | Working
        mds - Not Implemented
        interactclust - Not Implemented
        kmclust - Not Implemented
        prkmeans - Implemented | Working
        hdb - Not Implemented
        em - Not Implemented
    From Mapping
        gaussm - Implemented | Working (initialization) 
        parzenm - Implemented | Working (initialization) 
        knnm - Implemented | Working (initialization) 
        fisherm - Implemented | Working (initialization) 
    From Feature Selection
        fsel - Not Implemented
        featseli - Not Implemented
        featself - Not Implemented
        featselb - Not Implemented
        featsellr - Not Implemented
        featselo - Not Implemented
        featsel - Not Implemented
"""
# --- PRTOOLS DEPENDENCIES --- #
from prtools import *          #
from dataset import *          #
from uci import *              #
# ---------------------------- #
# --- Other DEPENDENCIES ----- #
import time            
import numpy as np        
import os
import glob
import ntpath
import math
import scipy
import sklearn
import matplotlib.pyplot as plt
# ---------------------------- #

def start():
    print("Importing libs ...")
    time.sleep(1)
    os.system("clear")
    
    active_list = []
    worker_list = []
    current_file_path = os.path.abspath(__file__)
    with open(current_file_path) as fp:
        lines = fp.readlines()
        for line in lines:
            line_search = line.strip()
            if len(line_search) and line_search[0] == '!':
                active_list.append(line_search[1:])
            if len(line_search) and line_search[0] == '*':
                worker_list.append(line_search[1:])

    print("Currently working on ...")    
    for i in range(len(active_list)):
         print("{0} by {1}".format(active_list[i], worker_list[i]))

def main():
    start()
    a = read_mat("diabetes")
    # print(a.lablist())
    # print(getsize(a))
    w = fisherm(a)
    print(w)
    # print(+a)
    # w = scipy.spatial.distance_matrix(a.data, a.data)

    # w = a*u
    # out = roc_n_plot(diabetes, 2)

if __name__ == '__main__':
    main()

'''
SOME NOTES ...
# Run prstartup.m first in Matlab before running any code.

# Helper websites while translating:
    https://numpy.org/doc/stable/user/numpy-for-matlab-users.html
    https://www.mathworks.com/help/matlab/matlab_prog/matlab-operators-and-special-characters.html

# PRTools Matlab path:
    ./prtools/BioSB-MachineLearning-2020_Translation/BioSB_essentials/Data_and_code/Data_and_code/prtools4112

# MAPPING.PY - how to train a mapping and evaluate a dataset
    w = nmc()
    w.train(a)
    b = w.eval(a)
    print(b)

# In PRTools ‘+a’ is short for ‘double(a)’ where ‘a’ is a ‘dataset’, the effect is to retrieve just the ‘data’ field from a ‘dataset’ structure.

# Loading datasets from .mat files in ./prtools/prtools/data folder:
    a = read_mat('cigars')
    print(a)
    scatterd(a) # to visualize the data
    print(prtools.getsize(a)) # get dimensions of the data set

# Usual workflow - meta analysis
    Open matlab and run ./prtools/BioSB-MachineLearning-2020_Translation/BioSB_essentials/Data_and_code/Data_and_code/prstartup.m

    1. Run method of interest on Matlab and take note of output
    2. Glance the code and take note of the form, behavior and flow
    3. Check if there are libs that enable the same behavior (e.g. scipy or sklearn)
    4. Note any dependent methods and assess time and complexity of the overall method
    5. Construct method and submethods in python using the same names
    6. Work on 5 until desired output (i.e. matches matlab's expected output)

# On the datasets (.mat files)
    Folder location: ./prtools/BioSB-MachineLearning-2020_Translation/BioSB_essentials/Data_and_code/Data_and_code/coursedata
    Other .mat files exist elsewhere (e.g. wine.mat) but these are not the correct data files since they can be missing fields that break loading methods (e.g. wine.mat from another folder is missing data field).

# When a is a dataset,
    a.featlab is getsize(a,2)'s amount
    a.data[:,0] is x
    a.data[:,1] is y    
    a[:,i,:] goes through featlabs where featlab is i
    a.targets returns the different classes 
    In uci.py, features are the data getsize(a,1)'s output and labels are getsize(a,3)'s output
'''