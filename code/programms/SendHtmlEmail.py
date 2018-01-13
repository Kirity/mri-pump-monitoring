#! /usr/bin/python

import smtplib

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import MySQLdb
import ConfigParser

cur = None
db = None



#Creating Constants
HTMLStart =  """<html> <head></head> <body> """
Break = """<br>"""
TableStart = """ <table align="center" border="1" cellpadding="1" cellspacing="1" width="600" > """
TableInvisibleStart = """ <table align="center" border="0" cellpadding="1" cellspacing="10" width="400" > """
RowStart = """ <tr> """
NormalColStart = """ <td bgcolor="#ffffff" style="text-align: center;"> """
NormalColLeftAlignStart = """ <td bgcolor="#ffffff"> """
HeadingColStart = """ <td bgcolor="#ffffff" style="text-align: center; font-weight:bold" > """
RedColStart = """ <td bgcolor="#ee4c50" style="text-align: center;" >"""
ColEnd = """ </td> """
RowEnd = """</tr> """
TableEnd = """ </table> """
HTMLEnd = """</body> </html>"""

#Misc
BoldStart = """ <strong> """
BoldEnd = """ </strong> """

try:
    print "In SendHtmlEmail.py file"
    config = ConfigParser.RawConfigParser()
    config.read('config.cfg')

    # me == my email address
    # you == recipient's email address
    #me = "MRIPumpMonitering@gmail.com"
    me = config.get('MailDetails','from')
    # Fullyou = ['k.rapuru@gmail.com','MRIPumpMonitering@gmail.com','johannes.krug@ovgu.de','sandro.schulze@iti.cs.uni-magdeburg.de']
    #you = "k.rapuru@gmail.com,MRIPumpMonitering@gmail.com"
    you = config.get('MailDetails','to')

    #Query
    jobHist = """SELECT JRH.ID,JRS.NAME RUN_STATUS,JRH.RUNTIME,JRH.MESSAGE,ML.NAME,LOC.LOCATION,JRH.JobRunStatus_ID 
                 FROM JOBRUNHISTORY JRH,mrilist ML,locations LOC,jobrunstatus JRS 
                 WHERE JRH.MRIList_ID = ML.ID
                 AND ML.LOCATIONID = LOC.ID
                 AND JRH.JobRunStatus_ID = JRS.ID 
                 AND JRH.MRILIST_ID ="""+ config.get('MRIDetails','MRI_ID') +" AND  (JRH.STATUSMAILSENT=0 OR JRH.STATUSMAILSENT IS NULL) "

    runStatus = """SELECT LOC.LOCATION,ML.NAME MRI_NAME,MT.NAME MEASURE_TYPE, PROCESSDATETIME,TOTALFILES,SUCCESSCOUNT,ERRORCOUNT  
                    FROM fileprocesshistory FPH, mrilist ML, measuretypes MT,locations LOC 
                    WHERE FPH.MRILIST_ID=ML.ID 
                    AND FPH.MeasureTypes_ID = MT.ID 
                    AND LOC.ID= ML.LOCATIONID 
                    AND FPH.PROCESSDATETIME=%s  
                    ORDER BY MT.ID """
    updateJobHist = "UPDATE JOBRUNHISTORY SET STATUSMAILSENT=1 WHERE ID= %s "


    MRI_ID = config.get('MRIDetails','MRI_ID')

    # Variables for MySQL
    db = MySQLdb.connect(host=config.get('Database','dbserverip')
                         ,user=config.get('Database','username')
                         ,passwd=config.get('Database','password')
                         ,db=config.get('Database','dbname')
                         ,port =int(conf.get('Database','port')))
    cur = db.cursor()

    cur.execute(jobHist)
    sendmail = cur.fetchall()
    for r in sendmail :
        msg = MIMEMultipart('alternative')
        print 'For Runtime', r[0], r[1],r[2],r[3],r[4],r[5]
        msg['Subject'] = r[5]+' '+r[4]+ " Job Status @ "+str(r[2])
        # Create message container - the correct MIME type is multipart/alternative.
        
        msg['From'] = me
        # msg['To'] = ",".join(you)
        msg['To'] = you
        #print msg
        # Create the body of the message (a plain-text and an HTML version).
        html  = HTMLStart + Break

        html += TableInvisibleStart + RowStart
        html += NormalColLeftAlignStart + str('Location') + ColEnd
        html += NormalColLeftAlignStart + str(r[5]) + ColEnd
        html += RowEnd

        html += RowStart
        html += NormalColLeftAlignStart + str('Pump name') + ColEnd
        html += NormalColLeftAlignStart + str(r[4]) + ColEnd
        html += RowEnd

        html += RowStart
        html += NormalColLeftAlignStart + str('Job execution time') + ColEnd
        html += NormalColLeftAlignStart + str(r[2]) + ColEnd
        html += RowEnd

        html += RowStart
        html += NormalColLeftAlignStart + str('Job run status') + ColEnd
        html += NormalColLeftAlignStart + str(r[1]) + ColEnd
        html += RowEnd

        html += RowStart
        html += NormalColLeftAlignStart + str('Job message') + ColEnd
        if int(r[6]) > 1 :
            html += RedColStart    + str(r[3]) + ColEnd
        else:
            html += NormalColLeftAlignStart + str(r[3]) + ColEnd
        html += RowEnd

        html += TableEnd
        html += Break

        #Stats table start
        html += TableStart + RowStart
        html += HeadingColStart + str("Log Files Name") + ColEnd  
        html += HeadingColStart + str("Number of Files Processed") + ColEnd
        html += HeadingColStart + str("Files Successed") + ColEnd
        html += HeadingColStart + str("Files Failed") + ColEnd
        html += RowEnd
        
        cur.execute(runStatus,(r[2]))
        history = cur.fetchall()
        for h in history :
            #print h[2],h[3],h[4],h[5],h[6]
            html += RowStart
            html += NormalColLeftAlignStart + str(h[2]) + ColEnd
            html += NormalColStart + str(h[4]) + ColEnd
            html += NormalColStart + str(h[5]) + ColEnd
            if int(h[6]) > 0 :
                html += RedColStart    + str(h[6]) + ColEnd
            else:
                html += NormalColStart + str(h[6]) + ColEnd

            html += RowEnd               

        html += TableEnd 
        html += HTMLEnd

        # Record the MIME types of both parts - text/plain and text/html.
        # part1 = MIMEText(text, 'plain')
        part2 = MIMEText(html, 'html')

        # Attach parts into message container.
        # According to RFC 2046, the last part of a multipart message, in this case
        # the HTML message, is best and preferred.
        #msg.attach(part1)
        msg.attach(part2)

        # Send the message via local SMTP server.
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login("MRIPumpMonitering@gmail.com", "inkamagdeburg")
        # sendmail function takes 3 arguments: sender's address, recipient's address
        # and message to send - here it is sent as one string.
        server.sendmail(me, you, msg.as_string())
        server.quit()
        cur.execute(updateJobHist,(r[0]))
        print 'Num of rows updated ',cur.rowcount
        if cur.rowcount==1 :
            db.commit()
        else:
            raise Exception('There seems to be some mis-match of updated rows')
except MySQLdb.Error as   sqlex:
    db.rollback()
    print ("Error code..",sqlex)        
except Exception as e:    
    print "Error while sending status mail  ... " , e
    
