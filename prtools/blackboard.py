"""
THIS IS A SCRIPT TO DEBUG METHODS USED IN PRTOOLS INCLUDING METHODS CONTAINED IN PRTOOLS.PY, UCI.PY AND DATASET.PY

Testing ...
    From Dataset Related, Distribution, Generation, Data Attributes
        !gauss 
            *Goncalo
    From Plotting
    From Generic prtools
    From Supervised methods
    From Unsupervised methods
    From Mapping
    From Feature Selection

Solving ...
    From Dataset Related, Distribution, Generation, Data Attributes
        setlabtype()
    From ploting:
		!plotf 
            *Goncalo
		gridsize
		plote
		hist2
    From Generic prtools
    From Supervised methods
    From Unsupervised methods
    From Mapping
    From Feature Selection
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
    diabetes = read_mat("diabetes")

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

# In PRTools ‘+a’ is short for ‘double(a)’ where ‘a’ is a ‘dataset’, the effect is to retrieve just the ‘data’ field from a ‘dataset’ structure.

# Checking datasets from .mat files in ./prtools/prtools/data folder:
    a = read_mat('cigars')
    print(a)
    scatterd(a)
    print(prtools.getsize(a))

# Usual workflow - meta analysis
    Open matlab and run ./prtools/BioSB-MachineLearning-2020_Translation/BioSB_essentials/Data_and_code/Data_and_code/prstartup.m

    1. Run method on Matlab and take note of output
    2. Glance the code and take note of the form, behavior and flow
    3. Check if there are libs that enable the same behavior (e.g. scipy or sklearn)
    4. Note any dependent methods and assess time and complexity of the overall method
    5. Construct method and submethods in python using the same names
    6. Test it until desired output (i.e. matches matlab's expected output)

# On the datasets (.mat files)
    Folder location: ./prtools/BioSB-MachineLearning-2020_Translation/BioSB_essentials/Data_and_code/Data_and_code/coursedata
    Other .mat files exist elsewhere (e.g. wine.mat) but these are not the same and can be missing fields that break loading methods (e.g. wine.mat from another folder is missing data field).

# When a is a dataset,
    a.featlab is getsize(a,2)'s amount
    a.data[:,0] is x
    a.data[:,1] is y    
    a[:,i,:] go through featlabs where featlab is i
    a.targets has the different classes
    #  In uci.py, features are the data getsize(a,1)'s output and labels are getsize(a,3)'s output
'''