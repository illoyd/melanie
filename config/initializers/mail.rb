Mail.defaults do
  retriever_method :imap, address:              'imap.mail.me.com',
                          port:                 993,
                          user_name:            ENV['IMAP_USER'],
                          password:             ENV['IMAP_PASSWORD'],
                          enable_ssl:           true

#   delivery_method :smtp,  address:              'smtp.mail.me.com',
#                           port:                 587,
#                           user_name:            ENV['MAIL_USER'],
#                           password:             ENV['MAIL_PASSWORD'],
#                           authentication:       :plain,
#                           enable_starttls_auto: true
end