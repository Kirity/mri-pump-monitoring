#!/usr/bin/python2 python
import os
import time
from datetime import datetime
import glob
import sys
import MySQLdb
from PIL import Image
import PIL.Image
import base64
import cStringIO
import ConfigParser
from time import strftime

cur = None
db = None
try:
    print "In SavingJobStatusFiles.py file"
    config = ConfigParser.RawConfigParser()
    config.read('config.cfg')
    #config.read('../config.cfg')
    query = "INSERT INTO JOBRUNHISTORY (JOBRUNSTATUS_ID,MRILIST_ID, RUNTIME,MESSAGE, CREATEDON) VALUES (%s,%s,%s,%s,now())"
    
    MRI_ID = config.get('MRIDetails','MRI_ID')
    #print 'MRI id is ',MRI_ID
    
    # Variables for MySQL
    db = MySQLdb.connect(host=config.get('Database','dbserverip')
                         ,user=config.get('Database','username')
                         ,passwd=config.get('Database','password')
                         ,db=config.get('Database','dbname')
                         ,port =int(conf.get('Database','port')))
    cur = db.cursor()
    #print "after db.coursor"
    files = glob.glob(config.get('LogsLocations','JobHistoryLocation')+"*.txt")
    
    #Checking archive folder and creating if it does not exist
    if not (os.path.isdir(config.get('LogsLocations', 'JobHistoryLocation') + config.get('LogsLocations', 'archiveFolder')+"/")):
        os.makedirs(config.get('LogsLocations', 'JobHistoryLocation') + config.get('LogsLocations', 'archiveFolder')+"/")
    for eachFile in files:
        try:
            #print "Inserting  : ",eachFile
            fullPath = eachFile.split("/")
            fileName = fullPath[len(fullPath)-1]
            with open (eachFile) as f:
                message = f.read()
            args = (fileName[20:21],MRI_ID,fileName[0:19],message)
            #print 'args are ',args
            cur.execute(query,args)
            if cur.rowcount == 1:
                print 'rows inserted ', cur.rowcount
                db.commit()
            else:
                raise Exception("One row should be inserted, but there is a mismatch : %s",cur.rowcount)            
            print "Success :"
            
            os.rename(eachFile,config.get('LogsLocations', 'JobHistoryLocation') + config.get('LogsLocations', 'archiveFolder')+"/"+fileName)                    
        except Exception as e:
            print e
            #print "Failure :", eachFile
            db.rollback()            
except Exception as e:    
    print "Error while commiting the data ... " , e

finally:    
    cur.close()
    db.close()
