# awstools
genneral repository for aws tools and scripts 

awsCheckTags.sh : checks for missing tags generates an email template and passes that to sendmail.py.   
runs as awsscript@nobux99 is using an useronly copy of awscli v1(installed in /home/awsscript/.local/lib/aws/bin/aws) with api keys bellonging to an awssvc user. 

sendmail.py : dirty little hack to send mails without an installed smtp server/agent only realy works with one mail at a time.  
