"""
THIS IS A SCRIPT TO DEBUG METHODS USED IN PRTOOLS INCLUDING METHODS CONTAINED IN PRTOOLS.PY, UCI.PY AND DATASET.PY
"""
# --- PRTOOLS DEPENDENCIES --- #
import prtools                 #
from dataset import *          #
from uci import *              #
# ---------------------------- #

def main():
    print('Running imports...')
    a = read_mat('cigars')
    print(a)
    scatterd(a)
    print(prtools.getsize(a))

if __name__ == '__main__':
    main()
    

'''
SOME DEBUGGING NOTES ...

# In PRTools ‘+a’ is short for ‘double(a)’ where ‘a’ is a ‘dataset’, the effect is to retrieve just the ‘data’ field from a ‘dataset’ structure.

'''
