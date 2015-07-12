# == God config file
# http://god.rubyforge.org/
# Authors: Gump and michael@glauche.de
#
# Config file for god that configures watches for each instance of a thin server for
# each thin configuration file found in /etc/thin.
# In order to get it working on Ubuntu, I had to make a change to god as noted at
# the following blog:
# http://blog.alexgirard.com/ruby-one-line-to-save-god/
#
require 'yaml'

file = File.join(File.expand_path(File.dirname(__FILE__)), 'config/thin.yml')
config = YAML.load_file(file)
pre_cmd = "export PATH=\"$HOME/.rbenv/bin:$PATH\" ; eval \"$(rbenv init -)\"; cd #{File.expand_path(File.dirname(__FILE__))}; "

(0...config["servers"]).each do |i|
  number = config['socket'] ? i : (config['port'] + i)

  God.watch do |w|
    w.name = "thin-#{number}"

    # w.chroot = File.expand_path(File.dirname(__FILE__))

    w.interval = 30.seconds

    w.start = "#{pre_cmd} bundle exec thin start -C #{file} -o #{number}"
    w.start_grace = 10.seconds

    w.stop = "#{pre_cmd} bundle exec thin stop -C #{file} -o #{number}"
    w.stop_grace = 10.seconds

    w.restart = "#{pre_cmd} bundle exec thin restart -C #{file} -o #{number}"
    w.pid_file = File.join(config["chdir"], "tmp/pids/thin.#{number}.pid")

    w.behavior(:clean_pid_file)

    w.start_if do |start|
      start.condition(:process_running) do |c|
        c.interval = 5.seconds
        c.running = false
      end
    end

    w.restart_if do |restart|
      restart.condition(:memory_usage) do |c|
        c.above = 150.megabytes
        c.times = [3,5] # 3 out of 5 intervals
      end

      restart.condition(:cpu_usage) do |c|
        c.above = 50.percent
        c.times = 5
      end
    end

    w.lifecycle do |on|
      on.condition(:flapping) do |c|
        c.to_state = [:start, :restart]
        c.times = 5
        c.within = 5.minutes
        c.transition = :unmonitored
        c.retry_in = 10.minutes
        c.retry_times = 5
        c.retry_within = 2.hours
      end
    end
  end
end
