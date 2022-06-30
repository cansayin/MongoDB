#!/bin/bash



#linkedin : https://www.linkedin.com/in/can-sayın-b332a157/
#cansayin.com


from="xxxx@xxxxxx.com"
to="xxxx@xxxxxx.com"
subject="MongoDB Monitoring Alerts : Long running queries and No. of Open connections"
echo " Hello Team," > /tmp/email_body.txt
echo " " >> /tmp/email_body.txt
echo "There are long running queries on the MongoDB server, please find attached txt file for details.">> /tmp/email_body.txt
echo "" >> /tmp/email_body.txt
mongo –port 27019 –eval "db.currentOp().inprog.forEach(function(op) {if(op.secs_running>1) {var output = {Optid : op.opid, Long_running_query : op.query, Running_time : op.secs_running}; printjson(output); } } )" > /tmp/long_running_queries.txt
NoOfOpenCon=`lsof | grep mongo | wc -l`
echo "Also please there around $NoOfOpenCon MongoDB Open connections on the server -please have a look">> /tmp/email_body.txt
echo "" >> /tmp/email_body.txt
echo "Thanks," >> /tmp/email_body.txt
echo "DBA Team" >> /tmp/email_body.txt
mutt -s $subject -a /tmp/long_running_queries.txt xxxx@xxxxxx.com < /tmp/email_body.txt
