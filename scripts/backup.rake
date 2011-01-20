# https://gist.github.com/787497
# by Robin

require 'fileutils'

namespace :backup do
  desc 'crontab -e'
  task :crontab do
    puts <<-CRONTAB
      m h d m d command
      0 3 * * * cd /var/www/do8 && /usr/bin/rake backup:log:all > /dev/null 2>&1
      5 3 * * * cd /var/www/do8 && /usr/bin/rake backup:db:mysql RAILS_ENV=production > /dev/null 2>&1
    CRONTAB
  end

  desc 'backup log'
  namespace :log do
    desc 'rake backup:log:all'
    task :all do
      # 建备份目录
      backup_path = File.join(Rails.root, 'backup', 'log', "#{Date.today.year}-#{Date.today.month}")
      FileUtils.mkdir_p(backup_path) unless File.exist?(backup_path)

      # 文件名
      filename = File.join(backup_path, "log_#{Time.now.strftime("%Y%m%d%H%M%S")}.tar.gz")

      # 执行备份命令
      cmd = "tar -czvf #{filename} log/*.log"
      `#{cmd}`
      Rake::Task["log:clear"].invoke if File.size?(filename)
    end
  end

  desc 'backup db'
  namespace :db do
    desc 'rake backup:db:mysql RAILS_ENV=production'
    task :mysql => :environment do
      # 建备份目录
      backup_path = File.join(Rails.root, 'backup', 'db', "#{Date.today.year}-#{Date.today.month}")
      FileUtils.mkdir_p(backup_path) unless File.exist?(backup_path)

      # 文件名
      tmp_filename = File.join(Rails.root, 'backup', 'db', 'tmp.sql')
      filename = File.join(backup_path, "db_#{Rails.env}_#{Time.now.strftime("%Y%m%d%H%M%S")}.tar.gz")

      # 获取数据库信息
      db_options = YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))[Rails.env].symbolize_keys

      # 执行备份命令
      cmd = <<-CMD
        mysqldump -u\"#{db_options[:username]}\" -p\"#{db_options[:password]}\" \
          --default-character-set=utf8 --opt --extended-insert=false \
          --triggers -R --hex-blob --single-transaction #{db_options[:database]} > #{tmp_filename}
        tar -czvf #{filename} backup/db/tmp.sql
      CMD
      `#{cmd}`
    end
  end
end
