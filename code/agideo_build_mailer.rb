# ccrb
# https://github.com/thoughtworks/cruisecontrol.rb
# 
# vi lib/builder_plugins/email_notifier.rb
# change
#  BuildMailer.send(template, build, @emails, from, *args)
# TO
#  AgideoBuildMailer.send(template, build, @emails, from, *args)
#
# console test
# AgideoBuildMailer.send(['robin.wu.cn@gmail.com','86695893@qq.com'], 'test fail')

class AgideoBuildMailer
  def self.deliver_build_report(build, recipients, from, subject, message, sent_at = Time.now)
    self.send(recipients, subject)
  end

  def self.send(recipients, subject)
    subject = CGI.escape(subject)
    cmd = "curl -s \"http://agi-notes.heroku.com/send_mail?t=#{recipients.join(",")}&s=#{subject}&b=#{subject}\""
    `#{cmd}`
  end
end
