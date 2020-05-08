#!/usr/bin/python
# -*- coding: utf-8 -*-
import sys
import os

def find_all_utf8_html_list(path, file_list):
    ret = 0
    errMsg = ""
    for root, dirs, files in os.walk(path):
        for file_name in files:
            if(file_name.find("html") != -1):
                source_file =  root + "/" + file_name
                file_list.append(source_file)
    return errMsg

def exec_conv_command(file_list):
    ret = 0
    errMsg = ""
    for source_file in file_list:
    	command = "iconv -f utf8 -t gbk -c -o " + source_file + "_bak" + " " + source_file
        print command
        #print '\n'
        os.system(command)
        command = "mv " + source_file + "_bak" + " " + source_file
        print command
        os.system(command)
    return errMsg

#def exec_conv_command(file_list):

if __name__ == '__main__':
    
    path = "/home/yw/data/innergpcode/20200507/hdb/manual/current_document/document/"
    file_list = []
    find_all_utf8_html_list(path, file_list)
    #print file_list
    print len(file_list)
    exec_conv_command(file_list)
