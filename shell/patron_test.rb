#!/usr/bin/ruby

sess = Patron::Session.new
sess.timeout = 10
sess.base_url = "http://192.168.2.32:3000"
resp = sess.get("/")
p resp.status == 400
