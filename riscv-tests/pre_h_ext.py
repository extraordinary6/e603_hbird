#!/usr/bin/python3
import sys

global_file = ""
ori_file = ""
gen_file = ""

for i in range(len(sys.argv)):
        # config file
        if sys.argv[i] == '-c':
            global_file = sys.argv[i+1]
        # indicate the input file 
        elif sys.argv[i] == '-i':
            ori_file = sys.argv[i+1]
        # indicate the gen file
        elif sys.argv[i] == '-o':
            gen_file = sys.argv[i+1]
        elif sys.argv[i] == '-h':
            sys.exit("usage: pre_process.py -c global_file -i input_file -o output_file")

if not global_file or not ori_file or not gen_file:
    sys.exit("usage: pre_process.py -c global_file -i input_file -o output_file")


# parge the global_file

define_dic = {}

with open(global_file) as r_file:
    for line in r_file:
        if "#define" in line:
            macro_name = line.split()[1]
            define_dic[macro_name] = True


with open(gen_file,"w") as w_file:
    with open(ori_file) as r_file:
        for line in r_file:
            if "#ifdef" in line and "CFG" in line:
                macro_name = line.split()[1]
                if macro_name in define_dic:
                    for line in r_file:
                        if "#endif" in line:
                            break
                        w_file.write(line)
                else:
                    for line in r_file:
                        if "#endif" in line:
                            break
            elif "#ifndef" in line and "CFG" in line:
                macro_name = line.split()[1]
                if macro_name not in define_dic:
                    for line in r_file:
                        if "#endif" in line:
                            break
                        w_file.write(line)
                else:
                    for line in r_file:
                        if "#endif" in line:
                            break
            else:
                w_file.write(line)
    
