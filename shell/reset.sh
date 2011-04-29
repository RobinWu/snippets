#!/bin/sh

# Rails version <= 2.3.8
# ps -Af | grep "script/server webrick -p 3000 -d" | kill -9 `awk {'print $2'}`
# echo '.'
# ruby ./script/server webrick -p 3000 -d
# echo '.'

# Rails version > 3.0.0
ps -Af | grep "rails s" | grep -v grep | awk '{print $2}' | xargs kill -9
echo '.'
rails s webrick -p 3000 -d
echo '.'
