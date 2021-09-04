"""
THIS IS A SCRIPT TO DEBUG METHODS USED IN PRTOOLS INCLUDING METHODS CONTAINED IN PRTOOLS.PY, UCI.PY AND DATASET.PY
"""
# --- PRTOOLS DEPENDENCIES --- #
from prtools import *          #
from dataset import *          #
from uci import *              #
# ---------------------------- #
# --- Other DEPENDENCIES --- 
import time            
import numpy as np        
import os
import glob
import ntpath
import math
import scipy
import sklearn
# ---------------------------- #

"""
Solving...
    From ploting:
		!plotf
		gridsize
		plote
		hist2
"""

def start():
    print("Importing libs ...")
    time.sleep(1)
    os.system("clear")

    current_file_path = os.path.abspath(__file__)
    with open(current_file_path) as fp:
        lines = fp.readlines()
        for line in lines:
            line_search = line.strip()
            if len(line_search) and line_search[0] == '!':
                print("Currently working on {}!".format(line_search[1:]))
                break

def main():
    start()
    diabetes = read_mat("diabetes")
    print(getsize(diabetes))
    plotf(diabetes)

if __name__ == '__main__':
    main()

'''
SOME NOTES ...

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
'''