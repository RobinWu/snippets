# ccrb
# https://github.com/thoughtworks/cruisecontrol.rb
# 
# vi lib/builder_plugins/email_notifier.rb
# change BuildMailer to AgideoBuildMailer
#
# console test
# AgideoBuildMailer.sent(['***@gmail.com','***@qq.com'], 'test fail')

class AgideoBuildMailer
  def self.deliver_build_report(build, recipients, from, subject, message, sent_at = Time.now)
    self.sent(recipients, subject)
  end

  def self.sent(recipients, subject)
    subject = CGI.escape(subject)
    cmd = "curl -s \"http://agi-notes.heroku.com/send_mail?t=#{recipients.join(",")}&s=#{subject}&b=#{subject}\""
    `#{cmd}`
  end
end
