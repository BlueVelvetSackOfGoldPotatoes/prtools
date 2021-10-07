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