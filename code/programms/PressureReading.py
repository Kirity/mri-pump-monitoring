#!/usr/bin/python2 python
import os
import time
from datetime import datetime
import glob
import MySQLdb
import ConfigParser
from time import strftime
 
query = "INSERT INTO PRESSURE (MRI_ID, MEASURED_DATE_TIME, VALUE ,PI_CREATEDDATE ,CREATEDDATE, LOGFILENAME ) VALUES (%s,%s,%s,%s,now(),%s)"
confirmation_Query = "SELECT COUNT(*) FROM PRESSURE WHERE PI_CREATEDDATE = %s  AND MRI_ID= %s AND LOGFILENAME = %s"
db = None
cur = None
filesCount = 0
errorCount = 0
succsessCount = 0
try:
    print 'In PressureReading.py'
    config = ConfigParser.RawConfigParser()
    config.read('config.cfg')
    #config.read('../config.cfg')
    MRI_ID = config.get('MRIDetails','MRI_ID')
    Type_ID = config.get('MeasureTypes','Pressure_TypeID')
    #print "After.."

    # Variables for MySQL
    db = MySQLdb.connect(host=config.get('Database','dbserverip')
                         ,user=config.get('Database','username')
                         ,passwd=config.get('Database','password')
                         ,db=config.get('Database','dbname')
                         ,port =int(conf.get('Database','port')))
    cur = db.cursor()
    #pi_dt = datetime.strptime(str(datetime.now().strftime("%Y-%m-%d %H:%M:%S")),"%Y-%m-%d %H:%M:%S")
    Pressurefiles = glob.glob(config.get('LogsLocations', 'PressureLogLocation')+'Pressure*.txt')
    #print Pressurefiles        
    for tmpfile in Pressurefiles:
        try:
            filesCount += 1
            #pi_dt = datetime.strptime(str(datetime.now().strftime("%Y-%m-%d %H:%M:%S")),"%Y-%m-%d %H:%M:%S")
            fullPath = tmpfile.split("/")            
            exactFile = fullPath[len(fullPath)-1]            
            with open (tmpfile) as f:
                lines = f.read().splitlines()    
                #lines = [line for line in lines if line.strip()]
            listArgs = []
            linesCount =0
            linesFromDB =0
            for line in lines :
                if len(line.strip()) > 0 :               
                    linesCount+=1               
                    # expects in form of YYYY-mm-dd HH:MM
                    dt = datetime.strptime(line[0:16],"%Y-%m-%d %H:%M")            
                    args = (MRI_ID, dt, line[17:],pi_dt,exactFile)
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
                print 'Actual lineCount ',linesCount,' From DB :',linesFromDB
                db.commit()
                succsessCount += 1
            else:
                raise Exception("Actual lines count is %s. did not match with DB value : %s " %(linesCount,linesFromDB))
        
            print "Success: ",exactFile
            if not (os.path.isdir(config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'archiveFolder')+"/")):
                os.makedirs(config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'archiveFolder')+"/")                
            os.rename(tmpfile,config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'archiveFolder')+"/"+exactFile)    
        except (Exception) as e  :
            print "Failed: ",exactFile, e
            errorCount += 1
            db.rollback()            
            print os.path.isdir(config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'errorFolder')+"/")
            if not (os.path.isdir(config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'errorFolder')+"/")):
                #print "Path does not exist..."+config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'errorFolder')+"/"
                os.makedirs(config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'errorFolder')+"/") 
            fo = open(config.get('LogsLocations', 'PressureLogLocation') + config.get('LogsLocations', 'errorFolder')+ "/"+ exactFile+"_Error.txt","wb")
            fo.write(str(e))
            fo.close()
            os.rename(tmpfile,config.get('LogsLocations', 'PressureLogLocation')+"errorlog/"+exactFile)                        
except MySQLdb.Error as   e:
    print "Error code..",e
except Exception as e:    
    print e

try:
    print 'Total Files',filesCount
    print 'Success Files : ',succsessCount
    print 'Error Files : ',errorCount
    fileProcArgs = (MRI_ID,Type_ID,pi_dt,filesCount,errorCount,succsessCount)
    cur.execute(FileProcess_Query,fileProcArgs)
    #print "File process query success",fileProcArgs
    if cur.rowcount == 1 :
        db.commit()
    else :
        raise Exception('There seems to be some mis-match of inserted rows')
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
    
    
