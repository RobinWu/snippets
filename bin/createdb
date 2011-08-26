#!/usr/bin/env ruby
#
# curl https://raw.github.com/RobinWu/snippets/master/shell/createdb.rb -o /tmp/createdb
# chmod +x /tmp/createdb
# mv /tmp/createdb /usr/local/bin/
#

require 'rubygems'
require 'optparse'

options = Hash.new()
opts = OptionParser.new() do |opts|
#   opts.on_tail("-h", "--help", "get help for this CMD") {
#     print(opts)
#     exit()
#   }
# 
#   opts.on("-p", "--user String", "Database user") { |user|
#     options[:user] = user
#   }
#   opts.on("-p", "--pwd String", "Database password") { |pwd|
#     options[:pwd] = pwd
#   }
#   opts.on("-d", "--db String", "Database name") { |db|
#     options[:db] = db
#   }
#   opts.on("-o", "--output String", "Output file") { |file|
#     options[:file] = file
#   }
end
opts.parse(ARGV)

class Mysql
  attr_accessor :root_pwd, :new_db_name, :new_db_user, :new_db_pwd

  def initialize(options={})
  end

  def gets_input_info(alert)
    puts alert
    while s = $stdin.gets.chomp
      return s
    end
  end

  def root_pwd
    @root_pwd ||= gets_input_info('Input root pwd:')
  end

  def new_db_name
    @new_db_name ||= gets_input_info('Input new database name:')
  end

  def new_db_user
    @new_db_user ||= gets_input_info('Input new database user:')
  end

  def new_db_pwd
    @new_db_pwd ||= gets_input_info('Input new database pwd:')
  end

  def run
    cmd = <<-CMD
       mysql -u root -p'#{self.root_pwd}' -e "CREATE DATABASE #{self.new_db_name} CHARACTER SET UTF8 COLLATE utf8_general_ci;" \
       mysql -u root -p'#{self.root_pwd}' -e "GRANT all ON #{self.new_db_name}.* TO '#{self.new_db_user}'@'localhost' IDENTIFIED BY '#{self.new_db_pwd}';"
    CMD
    `#{cmd}`

    <<-TXT
       New database name: #{self.new_db_name}
       New database user: #{self.new_db_user}
       New database  pwd: #{self.new_db_pwd}
    TXT
  end
end

puts Mysql.new(options).run
