#!/usr/bin/python
# -*- coding: utf-8 -*-
import sys
import os

replace_list = [['gpstart', 'hdbstart'],
                ['gpstop', 'hdbstop'],
                ['gpinitsystem', 'hdbinitsystem'],
                ['Greenplum', 'inHybrid'],
                ['GPHOME', 'HDBHOME'],
                ['gpadmin', 'hdbadmin'],
                ['gpactivatestandby', 'hdbactivatestandby'],
                ['gpconfig', 'hdbconfig'],
                ]


def find_all_utf8_html_list(path, file_list):
    for root, dirs, files in os.walk(path):
        for file_name in files:
            if (file_name.find("html") != -1):
                source_file = root + "/" + file_name
                file_list.append(source_file)
    if len(file_list) == 0:
        raise BaseException('no html file found')


def exec_replace_command(file_list):
    for source_file in file_list:
        for rep_data in replace_list:
            if len(rep_data) == 2:
                command = 'sed -i s#' + rep_data[0] + '#' + rep_data[1] + '#g ' + source_file
                os.system(command)


if __name__ == '__main__':
    try:
        path = os.path.abspath(sys.argv[0] + '/../../document/6-0/')
        file_list = []
        find_all_utf8_html_list(path, file_list)
        exec_replace_command(file_list)
    except BaseException as e:
        print 'exec replace error,', e
        exit(-1)
    print 'exec replace success'
