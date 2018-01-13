#!/usr/bin/python2 python
import glob
import MySQLdb
import ConfigParser
import sys
from datetime import datetime  
from time import strftime
try:
    import httplib
except:
    import http.client as httplib


##This method is used to test internet Connection
def is_internet_available():
    conn = httplib.HTTPConnection("www.google.com", timeout=5)
    try:
        conn.request("HEAD", "/")
        conn.close()
        return True
    except:
        conn.close()
        return False          
    
query = "SELECT 1 FROM DUAL"

FileProcess_Query = """INSERT INTO FILEPROCESSHISTORY
                       (MRILIST_ID, MEASURETYPES_ID,PROCESSDATETIME, TOTALFILES, ERRORCOUNT, SUCCESSCOUNT,CREATEDON)
                        VALUES(%s, %s, %s, %s, %s, %s,now() ) """
cur = None
db = None
fo = None
dbConnection = False
internetAvailable = False

conf = ConfigParser.RawConfigParser()

try:
    pi_dt = datetime.strptime(str(datetime.now().strftime("%Y-%m-%d %H:%M:%S")),"%Y-%m-%d %H:%M:%S")    
    conf.read('config.cfg')
    db = MySQLdb.connect(host=conf.get('Database','dbserverip'),user=conf.get('Database','username'),
                         passwd=conf.get('Database','password'), db=conf.get('Database','dbname'),port =int(conf.get('Database','port')))
    cur = db.cursor()
    cur.execute(query)
    result = cur.fetchall()
    cur.close()
    db.close()
    #Setting database connectivity flag
    dbConnection = True
    internetAvailable = is_internet_available()

    print 'Is internet available',internetAvailable

    tempratureFile =conf.get('code', 'codeLoc') + 'TemperatureReading.py'
    print  'Executing ',tempratureFile
    #sys.argv = [tempratureFile,logFile]
    execfile(tempratureFile)

    print 'Executing SaveTemperatureErrorLogs.py'
    execfile(conf.get('code', 'codeLoc')+'SaveTemperatureErrorLogs.py')

    print 'Executing ', 'PressureReading.py'
    execfile(conf.get('code', 'codeLoc')+'PressureReading.py')

    print 'Executing SavePressureErrorLogs.py'
    execfile(conf.get('code', 'codeLoc')+'SavePressureErrorLogs.py')

    print 'Executing ','ImagesReading.py'
    execfile(conf.get('code', 'codeLoc')+'ImagesReading.py')

    print 'Executing ', 'savingWavFiles.py'
    execfile(conf.get('code', 'codeLoc')+'savingWavFiles.py')

    print 'Files exection finish'
    fo = open(conf.get('LogsLocations','JobHistoryLocation')+str(pi_dt)+'_'+conf.get('RunStatus','Success') +'.txt','wb')          
except (MySQLdb.Error, MySQLdb.Warning ) as sqlex :
    # Mark Job run as DB error
    # If there is internet connection send mail
    fo = open(conf.get('LogsLocations','JobHistoryLocation')+str(pi_dt)+'_'+conf.get('RunStatus','DatabaseError') +'.txt','wb')
    fo.write(str(sqlex))
    print "In sql exception", sqlex
except Exception as  ex:
    # Mark Job run status as Error
    # Send mail if needed
    print "In Exception", ex
    fo = open(conf.get('LogsLocations','JobHistoryLocation')+str(pi_dt)+'_'+conf.get('RunStatus','UnExpectedError') +'.txt','wb')
    fo.write(str(ex))
    print "In Exception", ex
finally :
    if fo is not None:
        fo.close()

try:
    if dbConnection :
        print 'Executing ', 'SavingJobStatusFiles.py'
        execfile(conf.get('code', 'codeLoc')+'SavingJobStatusFiles.py')        
except Exception as  ex:
    print "Exception while saving Job status files ", ex

try:
    if dbConnection and internetAvailable :
        print 'Executing ', 'SendHtmlEmail.py'
        execfile(conf.get('code', 'codeLoc')+'SendHtmlEmail.py')

        print 'Executing ', 'SendAletEmails.py'
        execfile(conf.get('code', 'codeLoc')+'SendAlertEmails.py')
        
except Exception as  ex:
    print "Exception while saving Job status files ", ex
    
