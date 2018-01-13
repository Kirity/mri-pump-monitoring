#!/usr/bin/env python
import os
import time
from datetime import datetime
import glob
import sys
import MySQLdb
import wave
import base64
import cStringIO
import ConfigParser
from time import strftime


config = ConfigParser.RawConfigParser()
config.read('config.cfg') 
query = "INSERT INTO RECORDINGS (MRILIST_ID,VALUE,FILENAME,PI_CREATEDDATE,CREATEDDATE ) VALUES (%s,%s,%s,%s,now())"
filesCount = 0
errorCount = 0
succsessCount = 0

try:
    MRI_ID = config.get('MRIDetails','MRI_ID')
    MeasureTypeID = config.get('MeasureTypes','Sound_TypeID')

    # Variables for MySQL
    db = MySQLdb.connect(host=config.get('Database','dbserverip')
                         ,user=config.get('Database','username')
                         ,passwd=config.get('Database','password')
                         ,db=config.get('Database','dbname')
                         ,port =int(conf.get('Database','port')))
    cur = db.cursor()
    files = glob.glob(config.get('LogsLocations', 'waveFilesLocation')+"*.wav")

     #Creating an archive folder if it does not exist
    if not (os.path.isdir(config.get('LogsLocations', 'waveFilesLocation') + config.get('LogsLocations', 'archiveFolder')+"/")):
        os.makedirs(config.get('LogsLocations', 'waveFilesLocation') + config.get('LogsLocations', 'archiveFolder')+"/")

    for eachFile in files:
        filesCount += 1
        #pi_dt = datetime.strptime(str(datetime.now().strftime("%Y-%m-%d %H:%M:%S")),"%Y-%m-%d %H:%M:%S")
        #print "Inserting  : ",eachFile,pi_dt
        fullPath = eachFile.split("/")
        fileName = fullPath[len(fullPath)-1]
        #image= Image.open(file)
        blob_value = wave.open(eachFile,'rb')
        args = (MRI_ID, blob_value,fileName, pi_dt)
        try:
            cur.execute(query,args)
            if cur.rowcount == 1:
                print 'rows affected :',cur.rowcount
                db.commit()
                succsessCount += 1
                print "Success :",eachFile
            else:
                db.rollback()
                raise Exception("Expected 1 but query returned %s" %(cur.rowcount))

            #Moving file to archive folder 
            os.rename(eachFile,config.get('LogsLocations', 'waveFilesLocation') + config.get('LogsLocations', 'archiveFolder')+"/"+fileName)    
        except Exception as e:            
            print e
            print 'Exception while saving',eachFile
            errorCount += 1
except Exception as e:
    print e


try:
    fileProcArgs = (MRI_ID,MeasureTypeID,pi_dt,filesCount,errorCount,succsessCount)
    cur.execute(FileProcess_Query,fileProcArgs)
    #print "File process query success",fileProcArgs
    db.commit()
except MySQLdb.Error as   e:
    print ("Error code..",e)
except Exception as e:    
    print (e)

finally:
    if cur is not None:
        cur.close()
    if db is not None:
        db.close()


