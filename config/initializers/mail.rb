mail_conf = YAML.load_file(Rails.root.join('config', 'mail.yml'))
ActionMailer::Base.smtp_settings   = mail_conf
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: "utf-8"

