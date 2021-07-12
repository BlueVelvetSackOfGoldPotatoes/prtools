import re
import os
import subprocess
from os import path
from subprocess import call

# main_dir = "/home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code"

main_dir = "/home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data_and_code/prtools4112"

python_premade_methods_path = "./prtools.py"

file_python_method_names_path = "./python_functions.txt"
file_matlab_method_names_path = "./only_prtools_matlab_functions.txt"
file_comparision_path = "./comparision.txt"

def clear_files(files):
    '''
        Clears files.
    '''
    for file in files:
        f = open(file,"r+")
        f.truncate(0)
        f.close()

def write_ouput_to_file(output, lang):
    '''
        Writes output to files.
    '''
    if lang == "matlab":
        with open(file_matlab_method_names_path ,"a+") as f:
            file_path_truncated = output[0][115:]
            f.write("fn: " + output[1] + " -\n" + " fp: ..." + file_path_truncated + "\n")

    elif lang == "python":
        with open(file_python_method_names_path ,"a+") as f:
            f.write("fn: " + output + " -\n")

    elif lang == "comparision":
        with open(file_comparision_path ,"a+") as f:
            f.write(output)

def compare():
    '''
        Iterate through lines on both python and matlab method txt savers and compare the names of the functions
    '''
    with open(file_python_method_names_path,'r') as p:
        with open(file_matlab_method_names_path, 'r') as m:
            for pl in p:
                method_pl = re.match('fn: (.*) \\-', pl)
                method_pl = method_pl.group(1)
                for ml in m:
                    method_ml = re.match('fn: (.*) \\-', ml)
                    if method_ml != None:
                        method_ml = method_ml.group(1)
                        if method_ml == method_pl:
                            arrow = (40 - len(method_pl)) * "-"
                            output = method_pl + arrow + " YA \n"
                            write_ouput_to_file(output, "comparision" )
                            continue
                        else:
                            arrow = (40 - len(method_ml)) * "-"
                            output = method_ml + arrow + " NEE \n"
                            write_ouput_to_file(output, "comparision" )
                            continue

def crawl_matlab_methods(file_path, method_name):
    '''
        Iterate through lines until a non comment is found.
    '''
    with open(file_path, 'r', encoding="latin1", errors="surrogateescape") as f: 
        content = f.readlines()
        for x in content:
            x = x.rstrip()
            if x.startswith('%') == False:
                # save the name of the file because we assume that's the function
                # [path_to_file, name_of_function]
                file_save_string = [file_path, method_name]
                # print(file_save_string)
                write_ouput_to_file(file_save_string, "matlab")
                break

def crawl_python_methods():
    '''
        Iterate through lines until a function definition is found.
    '''
    with open(python_premade_methods_path,'r') as f: 
        for x in f:
            x = x.rstrip()
            if x[0:3] == 'def':
                method_name = re.match('def (.*)\\(', x)
                method_name = method_name.group(1)
                write_ouput_to_file(method_name, "python")
                
# In case a menu is useful
# def menu():
#     return input("Crawl python file: 1 \n Crawl matlab files: 2 \n Compare: 3 \n Exit: any other key... ")

def controller():
    # Clear files
    my_files = [file_matlab_method_names_path, file_comparision_path]
    clear_files(my_files)

    # Crawl through matlab files to find method names.
    for subdir, dirs, files in os.walk(main_dir):
        for file in files:    
            file_name = os.path.basename(file) 
            if file_name.endswith('.m'):
                n_list = file_name.split('.')
                crawl_matlab_methods(os.path.join(subdir, file), n_list[0])
    
    # Crawl through python prtools file to save method names for later comparision with found matlab file names.
    # crawl_python_methods()

    # Compare method names from the methods saved in the txt files.
    compare()

    # Delete duplicates because of @data anda @dataset and @mapping and organize alphabetically
    subprocess.call('cd /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data_and_code/', shell = True)
    subprocess.call('sort -u comparision.txt -o comparision.txt', shell = True)
    # subprocess.call('sort -u all_matlab_functions.txt -o all_matlab_functions.txt', shell = True)     
    # subprocess.call('sort -u only_prtools_matlab_functions.txt -o only_prtools_matlab_functions.txt', shell = True)     
    subprocess.call('sort -u python_functions.txt -o python_functions.txt', shell = True)     

def main():
    controller()
    
    # Possible implementation of a menu
    # while (option != 0):
    #     option = menu()
    #     match option:
    #         case "1":
            
    #         case "2":

    #         case "3":

    #         case _:
    #             exit()

if __name__ == '__main__':
    main()