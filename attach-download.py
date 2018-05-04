#!/usr/bin/env python

import imaplib
import email
import os
from pathlib import Path

# User config
svdir = 'save_directory'
smtp_server = 'mail_server'
mail_user = 'mail_example'
mail_password = 'password'
subject_filter = 'subject'

# login and enter Inbox
mail = imaplib.IMAP4_SSL(smtp_server, 993)
mail.login(mail_user, mail_password)
mail.select("Inbox")

# get mails of certain subject
typ, msgs = mail.search(None, '(SUBJECT "%s")' % subject_filter)
msgs = msgs[0].split()

for emailid in msgs:
    resp, data = mail.fetch(emailid, "(RFC822)")

    email_body = data[0][1]
    m = email.message_from_bytes(email_body)

    # only select the file with attachment
    if m.get_content_maintype() != 'multipart':
        continue

    for part in m.walk():
        if part.get_content_maintype() == 'multipart':
            continue
        if part.get('Content-Disposition') is None:
            continue

        if part.get_content_maintype() == 'text':
            content = part.get_payload().replace(' ', '_').replace('\n', '').replace('\r', '')
            continue
        filename = part.get_filename()
        # name the file by mail content
        print(content+'_'+filename)
        if filename is not None:
            sv_path = os.path.join(svdir, filename)
            download_file = Path(sv_path)
            if download_file.is_file():
                print("file exists!\n")
                continue
            print(sv_path)
            fp = open(sv_path, 'wb')
            fp.write(part.get_payload(decode=True))
            fp.close()
