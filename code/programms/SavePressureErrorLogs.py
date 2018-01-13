#!/usr/bin/python2 python
import os
import time
from datetime import datetime  
import glob
import MySQLdb
import ConfigParser
from time import strftime
 
query = "INSERT INTO ErrorLogs (Message, MeasuredDateTime,MRI_ID, MeasureTypes_ID, PI_DATETIME, CREATEDON , LOGFILENAME ) VALUES (%s, %s, %s, %s, %s, now(), %s)"

db = None
cur = None
filesCount = 0
errorCount = 0
succsessCount = 0
try:
    print 'In file SavePressureErrorLogs.py..'
    config = ConfigParser.RawConfigParser()
    #config.read('../config.cfg')
    config.read('config.cfg')
    MRI_ID = config.get('MRIDetails','MRI_ID')
    Type_ID = config.get('MeasureTypes','Pressure_Error_Log')
    MeasureTypes_ID = config.get('MeasureTypes','Pressure_TypeID')
    #print " Mri ID is " + MRI_ID
    #print " Measure Type ID  is " + MeasureTypes_ID

    # Variables for MySQL
    db = MySQLdb.connect(host=config.get('Database','dbserverip')
                         ,user=config.get('Database','username')
                         ,passwd=config.get('Database','password')
                         ,db=config.get('Database','dbname')
                         ,port =int(conf.get('Database','port')))
    cur = db.cursor()
    #pi_dt = datetime.strptime(str(datetime.now().strftime("%Y-%m-%d %H:%M:%S")),"%Y-%m-%d %H:%M:%S")
    PressureErrorfiles = glob.glob(config.get('LogsLocations', 'PressureLogLocation')+'Pressure*.error')


    #Checking archiveFolder is present or not
    if not (os.path.isdir(config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'archiveFolder')+"/")):
        os.makedirs(config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'archiveFolder')+"/")                

    #Checking error archive folder
    #print os.path.isdir(config.get('LogsLocations', 'TemperatureLogLocation') + config.get('LogsLocations', 'errorFolder')+"/")
    if not (os.path.isdir(config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'errorFolder')+"/")):
        #print "Path does not exist..."+config.get('LogsLocations', 'TemperatureLogLocation') + config.get('LogsLocations', 'errorFolder')+"/"
        os.makedirs(config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'errorFolder')+"/") 
    
    #print PressureErrorfiles    
    for tmpfile in PressureErrorfiles:
        try:
            filesCount += 1
            fullPath = tmpfile.split("/")            
            exactFile = fullPath[len(fullPath)-1]            
            with open (tmpfile) as f:
                message = f.read()
                print "Full text..",message
            listArgs = []
            conListArgs = []
            #print "Date time from File name "+exactFile[9:28]
            
            dt = datetime.strptime(exactFile[9:28],"%Y-%m-%d %H:%M:%S")                    

            args = (message, dt, MRI_ID, MeasureTypes_ID, pi_dt, exactFile)
            listArgs.append(args)
            cur.executemany(query,listArgs)
            if cur.rowcount == 1:
                db.commit()
                succsessCount += 1
            else:
                raise Exception("Rows count did not match.\n Actual lines read: One.\n Lines seems to be inserted in Database : %s" %(cur.rowcount))
            print ('Success: ',exactFile)
            
            os.rename(tmpfile,config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'archiveFolder')+"/"+exactFile)    
        except (Exception) as e  :
            print ('Failed: ',exactFile, e)
            db.rollback()
            errorCount += 1
            fo = open(config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'errorFolder')+ "/"+ exactFile+"_Error.txt","wb")
            fo.write(str(e))
            fo.close()
            os.rename(tmpfile,config.get('LogsLocations', 'PressureLogLocation')+"errorlog/"+exactFile)
                        
except MySQLdb.Error as   e:
    print ("Error code..",e)
except Exception as e:    
    print (e)

try:
    #print 'Total Files',filesCount
    #print 'Success Files : ',succsessCount
    #print 'Error Files : ',errorCount
    fileProcArgs = (MRI_ID,Type_ID,pi_dt,filesCount,errorCount,succsessCount)
    cur.execute(FileProcess_Query,fileProcArgs)
    #print "File process query success",fileProcArgs
    db.commit()
except MySQLdb.Error as   e:
    print ("Error code..",e)
except Exception as e:    
    print (e)
    
finally:
    #print "In 2nd finally..."
    if cur is not None:
        cur.close()
    if db is not None:
        db.close()
    
    
