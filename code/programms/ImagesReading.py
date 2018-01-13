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
filesCount = 0
errorCount = 0
succsessCount = 0
try:
    print "In ImagesReading.py file"
    config = ConfigParser.RawConfigParser()
    config.read('config.cfg')
    query = "INSERT INTO IMAGES (MRI_ID, IMAGE, FILENAME, PI_CREATEDDATE, CREATEDDATE) VALUES (%s,%s,%s,%s,now())"
    
    MRI_ID = config.get('MRIDetails','MRI_ID')
    MeasureTypeID = config.get('MeasureTypes','Image_TypeID')

    # Variables for MySQL
    db = MySQLdb.connect(host=config.get('Database','dbserverip'),user=config.get('Database','username'),
                             passwd=config.get('Database','password'), db=config.get('Database','dbname') ,port =int(conf.get('Database','port')))
    cur = db.cursor()
    #print "after db.coursor"
    files = glob.glob(config.get('LogsLocations','imageFilesLocation')+"*.jpg")

    #Creating an archive folder if it does not exist
    if not (os.path.isdir(config.get('LogsLocations', 'imageFilesLocation') + config.get('LogsLocations', 'archiveFolder')+"/")):
        os.makedirs(config.get('LogsLocations', 'imageFilesLocation') + config.get('LogsLocations', 'archiveFolder')+"/")

    for eachFile in files:
        #pi_dt = datetime.strptime(str(datetime.now().strftime("%Y-%m-%d %H:%M:%S")),"%Y-%m-%d %H:%M:%S")
        filesCount += 1
        #print "Inserting  : ",eachFile
        fullPath = eachFile.split("/")
        imageName = fullPath[len(fullPath)-1]
        image= Image.open(eachFile)
        blob_value = open(eachFile,'rb').read()
        args = (MRI_ID, blob_value, imageName, pi_dt)
        #print MRI_ID,MeasureTypeID,imageName, pi_dt
        try:
            cur.execute(query,args)
            if cur.rowcount == 1:
                print 'no of images inserted ',cur.rowcount
                db.commit()
                succsessCount += 1
            else:
                raise Exception("Only one row should be effected but returned value is ....%s" %(cur.rowcount))            
            print "Success :",eachFile
            #Moving file to archive folder 
            os.rename(eachFile,config.get('LogsLocations', 'imageFilesLocation') + config.get('LogsLocations', 'archiveFolder')+"/"+imageName)    
        except Exception as e:
            print e
            print "Failure :", eachFile
            db.rollback()
            errorCount += 1
except Exception as e:    
    print "Error while commiting the data ... " , e
try:
    #print 'Total Files',filesCount
    #print 'Success Files : ',succsessCount
    #print 'Error Files : ',errorCount
    fileProcArgs = (MRI_ID,MeasureTypeID,pi_dt,filesCount,errorCount,succsessCount)
    cur.execute(FileProcess_Query,fileProcArgs)
    #print "File process query success",fileProcArgs
    db.commit()
except MySQLdb.Error as   e:
    print ("Error code..",e)
except Exception as e:    
    print (e)


finally:    
    cur.close()
    db.close()
