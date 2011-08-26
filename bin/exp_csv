#!/usr/bin/env ruby

# Example
# exp_csv -u root -p -d <database> -t <table> -o <output-file>
#
# SQL Example
# SELECT columns FROM table_name WHERE whatever='something' INTO OUTFILE "/tmp/outfile.txt";
# echo "SELECT columns FROM table_name WHERE whatever='something'" | /path/to/mysql -uUSERNAME -pPASSWORD DATABASENAME > /tmp/outfile.txt; 
# /path/to/mysql -uUSERNAME -pPASSWORD DATABASENAME < /tmp/sql.sql > /tmp/outfile.txt;

require 'optparse'
options = Hash.new()
opts = OptionParser.new() do |opts|
  opts.on_tail("-h", "--help", "get help for this CMD") {
    print(opts)
    exit()
  }

  opts.on("-u", "--user String", "Database user") { |user|
    options[:user] = user
  }
  opts.on("-d", "--db String", "Database name") { |db|
    options[:db] = db
  }
  opts.on("-t", "--table String", "Table name") { |table|
    options[:table] = table
  }
  opts.on("-o", "--output String", "Output file") { |file|
    options[:file] = file
  }
end
opts.parse(ARGV)

# cmd = "echo 'SELECT * FROM #{options[:table]}' | mysql -u#{options[:user]} -p #{options[:db]} > #{options[:file]}"
cmd = <<-CMD
  mysql -u#{options[:user]} -p #{options[:db]} -B -e 'SELECT * FROM #{options[:table]}' | sed 's\/\\t\/","\/g;s\/^\/"\/;s\/$\/"\/;s\/\\n\/\/g' > #{options[:file]}
CMD
`#{cmd}`
print "."
