#!/usr/bin/python2 python
import os
import time
from datetime import datetime  
import glob
import MySQLdb
import ConfigParser
import sys
from time import strftime
 
query = "INSERT INTO Temperature (MRI_ID, VALUE, MEASURED_DATE_TIME, PI_CREATEDDATE, CREATEDDATE, LOGFILENAME) VALUES (%s, %s, %s, %s, now(), %s)"
confirmation_Query = "SELECT COUNT(*) FROM Temperature WHERE PI_CREATEDDATE = %s  AND MRI_ID=%s AND  LOGFILENAME = %s "
db = None
cur = None
filesCount = 0
errorCount = 0
succsessCount = 0
try:
    config = ConfigParser.RawConfigParser()
    #config.read('../config.cfg')
    config.read('config.cfg')
    MRI_ID = config.get('MRIDetails','MRI_ID')
    Type_ID = config.get('MeasureTypes','Temperature_TypeID')

    # Variables for MySQL
    db = MySQLdb.connect(host=config.get('Database','dbserverip')
                         ,user=config.get('Database','username')
                         ,passwd=config.get('Database','password')
                         ,db=config.get('Database','dbname')
                         ,port =int(conf.get('Database','port')))
    cur = db.cursor()
    Temperaturefiles = glob.glob(config.get('LogsLocations', 'TemperatureLogLocation')+'Temperature*.txt')
    #pi_dt = datetime.strptime(str(datetime.now().strftime("%Y-%m-%d %H:%M:%S")),"%Y-%m-%d %H:%M:%S")
    print 'List of files', Temperaturefiles

    #Creating an archive folder if it does not exist
    if not (os.path.isdir(config.get('LogsLocations', 'TemperatureLogLocation') + config.get('LogsLocations', 'archiveFolder')+"/")):
        os.makedirs(config.get('LogsLocations', 'TemperatureLogLocation') + config.get('LogsLocations', 'archiveFolder')+"/")

    #Creating error archive foder if it does not exist
    if not (os.path.isdir(config.get('LogsLocations', 'TemperatureLogLocation') + config.get('LogsLocations', 'errorFolder')+"/")):
        #print "Path does not exist..."+config.get('LogsLocations', 'TemperatureLogLocation') + config.get('LogsLocations', 'errorFolder')+"/"
        os.makedirs(config.get('LogsLocations', 'TemperatureLogLocation') + config.get('LogsLocations', 'errorFolder')+"/") 

    for tmpfile in Temperaturefiles:
        try:
            filesCount += 1
            fullPath = tmpfile.split("/")            
            exactFile = fullPath[len(fullPath)-1]            
            with open (tmpfile) as f:
                lines = f.read().splitlines()    
                #lines = [line for line in lines if line.strip()]
                print "no of lines..",len(lines)
            listArgs = []
            conListArgs = []
            linesCount =0
            linesFromDB =0
            for line in lines :
                if len(line.strip()) > 0 :                     
                    # expects in form of YYYY-mm-dd HH:MM
                    linesCount+=1
                    dt = datetime.strptime(line[0:16],"%Y-%m-%d %H:%M")                    
                    args = (MRI_ID,line[17:], dt ,pi_dt,exactFile)
                    listArgs.append(args)
                    #print args        
            cur.executemany(query,listArgs)

            #Code to confirm from database
            #print "No of lines..",linesCount
            conListArgs = (pi_dt,MRI_ID,exactFile)
            cur.execute(confirmation_Query,conListArgs)
            result = cur.fetchall()
            linesFromDB = result[0][0]
            #print "Result...",linesFromDB             
            if (linesFromDB) == linesCount:
                db.commit()
                succsessCount += 1
            else:
                raise Exception("Lines count did not match.\n Actual lines read: %s.\n Lines seems to be inserted in Database : %s" %(linesCount,linesFromDB))
            print ('Success: ',exactFile)

            #Moving file to archive folder 
            os.rename(tmpfile,config.get('LogsLocations', 'TemperatureLogLocation') + config.get('LogsLocations', 'archiveFolder')+"/"+exactFile)    
        except (Exception) as e  :
            print  'Failed: ',exactFile, e
            errorCount += 1
            print "errorcount ",errorCount
            db.rollback()            
            #print os.path.isdir(config.get('LogsLocations', 'TemperatureLogLocation') + config.get('LogsLocations', 'errorFolder')+"/")
            
            fo = open(config.get('LogsLocations', 'TemperatureLogLocation') + config.get('LogsLocations', 'errorFolder')+ "/"+ exactFile+"_Error.txt","wb")
            fo.write(str(e))
            fo.close()
            os.rename(tmpfile,config.get('LogsLocations', 'TemperatureLogLocation')+"errorlog/"+exactFile)
                        
except MySQLdb.Error as   e:
    print  ("Error code..",e)
except Exception as e:    
    print e
try:
    print 'Total Files',filesCount
    print 'Success Files : ',succsessCount
    print 'Error Files : ',errorCount
    fileProcArgs = (MRI_ID,Type_ID,pi_dt,filesCount,errorCount,succsessCount)
    cur.execute(FileProcess_Query,fileProcArgs)
    #print "File process query success",fileProcArgs
    db.commit()
except MySQLdb.Error as   e:
    print ("Error code..",e)
except Exception as e:    
    print (e)
finally:
    print "Temperature File...Finally"
    if cur is not None:
        cur.close()
    if db is not None:
        db.close()
    
    
