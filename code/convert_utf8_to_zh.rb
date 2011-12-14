require 'rubygems'
require 'json'
require 'activesupport'

def convert(cont)
  cont.gsub!(/\\([\\\/]|u[[:xdigit:]]{4})/) do
    ustr = $1
    if ustr.start_with?('u')
      [ustr[1..-1].to_i(16)].pack("U")
    elsif ustr == '\\'
      '\\\\'
    else
      ustr
    end
  end
end

json = ActiveSupport::JSON.encode({:aa => '我是谁abc'})
puts json
puts convert(json)
