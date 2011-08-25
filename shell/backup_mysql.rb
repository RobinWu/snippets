#!/usr/bin/env ruby
#
# apt-get install gzip
# curl https://raw.github.com/RobinWu/snippets/master/shell/backup_mysql.rb -o /tmp/backup_mysql
# chmod +x /tmp/backup_mysql
# mv /tmp/backup_mysql /usr/local/bin/
#

require 'rubygems'
require 'optparse'

options = Hash.new()
options[:zip] = false
opts = OptionParser.new() do |opts|
  opts.on_tail("-h", "--help", "get help for this CMD") {
    print(opts)
    txt = <<-TXT

       ============================================
       Example
       backup_mysql -u <user> -p <pwd> -d <database> -o <filename>
    TXT
    print(txt)
    exit()
  }

  opts.on("-u", "--user String", "Database user") { |user|
    options[:user] = user
  }
  opts.on("-p", "--pwd String", "Database password") { |pwd|
    options[:pwd] = pwd
  }
  opts.on("-d", "--db String", "Database name") { |db|
    options[:db] = db
  }
  opts.on("-o", "--output String", "Output file") { |file|
    options[:file] = file
  }
  opts.on("-z", "--zip", "Zip output file") {
    options[:zip] = true
  }
end
opts.parse(ARGV)

class Mysql
  attr_accessor :user, :pwd, :db, :file, :zip

  def initialize(options={})
    self.user = options[:user]
    self.pwd = options[:pwd]
    self.db = options[:db]
    self.file = options[:file]
    self.zip = options[:zip]
  end

  def user
    @user ||= gets_input_info('Input database username:')
  end

  def pwd
    @pwd ||= gets_input_info('Input database password:')
  end

  def db
    @db ||= gets_input_info('Input database name:')
  end

  def file
    @file ||= "./#{self.db}#{Time.now.strftime("%Y%m%d%H%M%S")}.sql"
  end

  def net_buffer_length
    cmd = <<-CMD
      mysql -u#{self.user} -p'#{self.pwd}' -e "SHOW VARIABLES LIKE 'net_buffer_length';"
    CMD
    `#{cmd}`.match(/(\d+)/) && $1
  end

  def max_allowed_packet
    cmd = <<-CMD
      mysql -u#{self.user} -p'#{self.pwd}' -e "SHOW VARIABLES LIKE 'max_allowed_packet';"
    CMD
    `#{cmd}`.match(/(\d+)/) && $1
  end

  def run
    cmd = <<-CMD
      mysqldump -u#{self.user} -p'#{self.pwd}' \
      --skip-opt --create-option --set-charset --default-character-set=utf8 \
      -e --max_allowed_packet=#{max_allowed_packet} --net_buffer_length=#{net_buffer_length} #{self.db} > #{self.file}
    CMD
    `#{cmd}`

    return self.file unless self.zip

    `gzip #{self.file}`
    "#{self.file}.gz"
  end

  private

    def gets_input_info(alert)
      puts alert
      while s = $stdin.gets.chomp
        return s
      end
    end
end

puts Mysql.new(options).run
