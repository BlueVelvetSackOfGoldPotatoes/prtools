"""
THIS IS A SCRIPT TO DEBUG METHODS USED IN PRTOOLS INCLUDING METHODS CONTAINED IN PRTOOLS.PY, UCI.PY AND DATASET.PY

There are notes regarding the debugging of this program to be read in the README.txt.

Testing ...
    From Dataset Related, Distribution, Generation,
        mogc - Implemented | Working
        extractClass - Implemented | Working
        genlab - Implemented | Working
        getlabels - Not Implemented
        getlablist - Not Implemented
        seldat - Implemented | Working
        boomerangs - Implemented | Working
        variances - Implemented | Working
        gendatsinc - Implemented | Working
        gendats3 - Implemented | Working
        gendatb - Implemented | Working
        gendatc - Implemented | Working
        gendatd - Implemented | Working
        gendath - Implemented | Working
        gendatdd - Implemented | Not Working because of gauss dependency
        setfeatlab - Not Implemented
        !gendatk - Implemented | Not Working
            *Goncalo
        gendatp - Implemented | Not Working
        gendatgauss - Implemented | Not Working
        gauss - Implemented | Not Working
        gendats - Implemented | Not Working
        gendat - Implemented | Working
        getlab - Not Implemented
        getprior - Implemented | Working
        setprior - Not Implemented
        gettargets - Implemented | Working
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
        plotm - Implemented | Working
        plote - Not Implemented
        plotc - Implemented | Working
        plotdg - Implemented | Working
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
        lassoc - Implemented | Working
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
        hclust - Implemented | Working
        pcam - Implemented | Working
        mds - Not Implemented
        interactclust - Not Implemented
        kmclust - Not Implemented
        ridger - Implemented | Working
        lassor - Implemented | Working
        prkmeans - Implemented | Working
        kmeans - Implemented | Working
        hdb - Not Implemented
        em - Not Implemented
    From Mapping
        llem - Implemented | Working
        isomapm - Implemented | Working
        gaussm - Implemented | Working (initialization) 
        parzenm - Implemented | Working (initialization) 
        knnm - Implemented | Working (initialization) 
        fisherm - Implemented | Working (initialization) 
    From Feature Selection
        fsel - Not Implemented
        featseli - Implemented | Working
        featself - Implemented | Working
        featselb - Implemented | Working
        featsellr - Not Implemented
        featselo - Implemented | Working
        featsel - Not Implemented
"""
# --- PRTOOLS DEPENDENCIES --- #
from prtools import *          #
from dataset import *          #
from uci import *              #
# ---------------------------- #
# --- Other DEPENDENCIES ----- #
import time                  
import os
# ---------------------------- #

def start():
    """
    Import libraries, load dependencies and output who is working on what.
    """
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
        print("{0} \n  - {1}".format(active_list[i], worker_list[i]))

def main():
    start()
    # Load a dataset
    a = read_mat("diabetes")
    # Visualize the dataset
    scatterdui(a)

if __name__ == '__main__':
    main()