#!/usr/bin/env python3

import sys
import smtplib
from email.mime.text import MIMEText
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-v', type=str, required=True)
recipients = args = parser.parse_args().v
data = sys.stdin.readlines()
subject = data.pop(0).rstrip()
message = "".join(data)

def send(recipient, sub, txt):
    msg =  MIMEText(txt)
    me = 'dud@nobia.com'
    you = recipient
    msg['Subject'] = 'test of script to sent data'
    msg['From'] = me
    msg['To'] = you
    # Send the message via our own SMTP server, but don't include the
    # envelope header.
    s = smtplib.SMTP('internalsmtp.nobianet.global')
    s.sendmail(me, [you], msg.as_string())
    s.quit()

send(recipients, subject, message)
print("sending to: " + recipients)
