#!/usr/bin/env rackup
##\ -E deployment

# gem install rack
# vi simple_htpp_server.ru
# chmod +x simple_htpp_server.ru
# rackup simple_htpp_server.ru

use Rack::ContentLength

app = Rack::Directory.new Dir.pwd
run app
