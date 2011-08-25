#!/usr/bin/env ruby

require 'rubygems'
require 'optparse'

options = Hash.new()
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
end
opts.parse(ARGV)

class Mysql
  attr_accessor :user, :pwd, :db, :file

  def initialize(options={})
    self.user = options[:user]
    self.pwd = options[:pwd]
    self.db = options[:db]
    self.file = options[:file]
  end

  def user
    return @user if @user

    puts 'Input database username:'
    while s = $stdin.gets.chomp
      @user = s
      return @user
    end
  end

  def pwd
    return @pwd if @pwd

    puts 'Input database password:'
    while s = $stdin.gets.chomp
      @pwd = s
      return @pwd
    end
  end

  def db
    return @db if @db

    puts 'Input database name:'
    while s = $stdin.gets.chomp
      @db = s
      return @db
    end
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
    self.file
  end
end

puts Mysql.new(options).run
