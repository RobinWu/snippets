require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = 'http://www.google.cn/search?q=tenderlove'
doc = Nokogiri::HTML(open(url))

doc.css('h3.r a.l').each do |link|
  puts link.content
end
puts '--------------------------------------------------'

doc.xpath('//h3/a[@class="l"]').each do |link|
  puts link.content
end
puts '--------------------------------------------------'

doc.search('h3.r a.l', '//h3/a[@class="l"]').each do |link|
  puts link.content
end
