#!/usr/bin/python
# -*- coding: utf-8 -*-
import base64
import json
import sys
import os
reload(sys)
sys.setdefaultencoding( "utf-8" )
catalog_id = 0



def make_one_catalog_info(catalog_id, title, url, hassub, level):
    ret = 0
    errMsg = ""
    result = "TitleList.Title." + str(catalog_id) + "=" + title + "\n"
    result = result + "TitleList.Level." + str(catalog_id) + "=" + str(level) + "\n"
    result = result + "TitleList.Url." + str(catalog_id) + "=" + url + "\n"
    result = result + "TitleList.Icon." + str(catalog_id) + "=0" + "\n"
    result = result + "TitleList.Status." + str(catalog_id) + "=0" + "\n"
    result = result + "TitleList.Keywords." + str(catalog_id) + "=" + "\n"
    result = result + "TitleList.ContextNumber." + str(catalog_id) + "=" + str(catalog_id + 1000) + "\n"
    result = result + "TitleList.ApplyTemp." + str(catalog_id) + "=0" + "\n"
    result = result + "TitleList.Expand." + str(catalog_id) + "=0" + "\n"
    result = result + "TitleList.Kind." + str(catalog_id) + "=0"
    #result = result.encode("GB2312")

    return result



def make_catalog_info(catalog_file_path, dest_file_path):
    with open(catalog_file_path) as f:
        str1 = f.read()
    jsonobj = json.loads(str1)
    deal_catalog_json(jsonobj)

def deal_catalog_json(jsonobj):
    global catalog_id
    if len(jsonobj['subdir']) == 0:
        hassub = False
    else:
        hassub = True;
    title = jsonobj['dirname']
    url = jsonobj['link_href']
    if (url.find('6-0') != -1):
        url = url[url.index('6-0'):len(url)]
        url = url.replace('/','\\')
    level = jsonobj['level']
    result = make_one_catalog_info(catalog_id, title, url, hassub, level)
    print result
    catalog_id = catalog_id + 1;
    if hassub:
        for subobj in jsonobj['subdir']:
            deal_catalog_json(subobj)

        #print level
    #    hassub = 2
    #    one_catalog_info = make_one_catalog_info(i, title, url, hassub, int(level))
    #    print one_catalog_info 
    #    i = i + 1
    #return errMsg

if __name__ == '__main__':

    catalog_file_path = "pxf.json"
    dest_file_path = "aaaa"
    make_catalog_info(catalog_file_path, dest_file_path)
