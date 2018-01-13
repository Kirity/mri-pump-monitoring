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
TableStart = """ <table align="center" border="1" cellpadding="1" cellspacing="1" width="300" > """
TableInvisibleStart = """ <table align="center" border="0" cellpadding="1" cellspacing="10" width="300" > """
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

sendMailFlag = False

try:
    print "In ExecuteAlertEmail.py file"
    config = ConfigParser.RawConfigParser()
    config.read('config.cfg')

    # me == my email address
    # you == recipient's email address
    me = config.get('MailDetails','from')
    # Fullyou = ['k.rapuru@gmail.com','MRIPumpMonitering@gmail.com','johannes.krug@ovgu.de','sandro.schulze@iti.cs.uni-magdeburg.de']
    you = config.get('MailDetails','to')
    
    #Query
    histQ = """SELECT JRH.ID,LOC.LOCATION,ML.NAME MRI_NAME,JRH.RUNTIME,JRH."""+colName+"""  
                FROM JOBRUNHISTORY JRH,mrilist ML,locations LOC 
                WHERE JRH.MRIList_ID = ML.ID
                AND ML.LOCATIONID = LOC.ID 
                AND JRH.MRILIST_ID =%s 
                AND (JRH."""+colName+""" IS NULL OR JRH."""+colName+"""  =0) """
    
    alertTempQuery = """ SELECT T.MEASURED_DATE_TIME,T.VALUE FROM """+tableName+""" T 
                        WHERE T.PI_CREATEDDATE = %s  
                        AND T.VALUE > (SELECT VALUE FROM thresholdvalues WHERE MeasureTypes_ID=%s ) 
                        AND T.MRI_ID=%s; """
    updateJobHist = """ UPDATE  JOBRUNHISTORY SET """+colName+"""=1 WHERE ID=%s """

    MRI_ID = config.get('MRIDetails','MRI_ID')
    #Type_ID = config.get('MeasureTypes','Temperature_TypeID')

    # Variables for MySQL
    db = MySQLdb.connect(host=config.get('Database','dbserverip'),user=config.get('Database','username'),
                             passwd=config.get('Database','password'), db=config.get('Database','dbname'))
    cur = db.cursor()

    cur.execute(histQ,(MRI_ID))
    sendmail = cur.fetchall()
    for r in sendmail :
        msg = MIMEMultipart('alternative')
        print 'For Runtime', r[0],'#', r[1],'#',r[2],'#',r[3]
        msg['Subject'] = str(r[1])+' '+str(r[2])+' '+ alertName+ "  Alert @ "+str(r[3])
        # Create message container - the correct MIME type is multipart/alternative.
        
        msg['From'] = me
        # msg['To'] = ",".join(you)
        msg['To'] = you
        #print msg
        # Create the body of the message (a plain-text and an HTML version).
        html  = HTMLStart + Break

        html += TableInvisibleStart + RowStart
        html += NormalColLeftAlignStart + str('Location') + ColEnd
        html += NormalColLeftAlignStart + str(r[1]) + ColEnd
        html += RowEnd

        html += RowStart
        html += NormalColLeftAlignStart + str('Pump name') + ColEnd
        html += NormalColLeftAlignStart + str(r[2]) + ColEnd
        html += RowEnd

        html += RowStart
        html += NormalColLeftAlignStart + str('Job execution time') + ColEnd
        html += NormalColLeftAlignStart + str(r[3]) + ColEnd
        html += RowEnd
        
        html += TableEnd
        html += Break

        #Stats table start
        html += TableStart + RowStart
        html += HeadingColStart + str("Measured time") + ColEnd  
        html += HeadingColStart + str("Value") + ColEnd
        html += RowEnd

        cur.execute(alertTempQuery,(r[3],Type_ID,MRI_ID))
        history = cur.fetchall()
        print 'Alert rows ',cur.rowcount
        if cur.rowcount > 1 :
            sendMailFlag = True
        else :
            sendMailFlag = False
            
        for h in history :            
            html += RowStart
            html += NormalColLeftAlignStart + str(h[0]) + ColEnd
            html += RedColStart    + str(h[1]) + ColEnd
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
        if sendMailFlag :
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
    
