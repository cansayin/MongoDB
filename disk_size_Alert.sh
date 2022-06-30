#!/usr/bin/python

#this scripts check disk sizes and send email if disk size is high.


#linkedin : https://www.linkedin.com/in/can-sayın-b332a157/
#cansayin.com


# -*- coding: utf-8 -*-
import os
import smtplib
from datetime import datetime
from dateutil.tz import tzlocal
now = datetime.now(tzlocal()).isoformat()
sender = "mongouser@test.com"
receivers = ['test@test.com', 'test@test.com']
subject = "MongoDB Disk Size Problem Alert"
text = "SUMMARY : Something went wrong,  %85 of '/Products/mongo_data' disk size is full !! Please check the server. \r\n" + "ALERT : MongoDB Disk Size Problem \r\n" + "NODE : dxlmngdp1(10.86.57.235) \r\n" + "DATE : " + str(now) + "\r\n" + "SEVERITY : 5"
message = "From: %s \r\n" % sender + "To: %s \r\n" % ", ".join(receivers) + "Subject: %s \r\n" % subject + "\r\n" + text
st = os.statvfs('/Products/mongo_data')
#free = st.f_bavail * st.f_frsize
total = st.f_blocks * st.f_frsize
used = (st.f_blocks - st.f_bfree) * st.f_frsize
print str(now)
print  "Total size : %d Bytes = %.2f GBytes" % (total, total/1024/1024/1024)
print  "Used size : %d Bytes = %.2f GBytes" % (used, used/1024/1024/1024)
if (used >= total*50/100):
   print "Disk size is about to full!"
   smtpObj = smtplib.SMTP("localhost")
   smtpObj.sendmail(sender, receivers, message)
   print "Successfully sent email!"
else :
   print "Disk size is normal."
