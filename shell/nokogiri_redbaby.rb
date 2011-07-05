require 'rubygems'
require 'nokogiri'
require 'open-uri'

all = Nokogiri::HTML(open('http://www.redbaby.com.cn/'))
all.css('div.headSortBody_101015 div.thirdLevel ul li a').each do |a|
  url = a['href'].strip.delete("\n\t")
  begin
    page = Nokogiri::HTML(open(url))
  rescue Exception=>err
    p err
    next
  end
  while page
    page.css("div.listGoodsInner").each do |product|
      begin
        p product.css("div.listGoodsName a").text.strip
        p product.css("div.listGoodsName a")[0]["href"]
        p product.css("div.listGoodsPic a img")[0]["src"]
        price = product.css("div.listGoodsPrice span.price02").text.strip
        price = price[3, price.size - 3].delete(',').to_f
        p price

      rescue Exception => err
        p err
      end
    end
    if page.css("a.right")[0] && page.css("a.right")[0]["href"]
      page = Nokogiri::HTML(open("http://www.redbaby.com.cn/Product/" + page.css("a.right")[0]["href"].strip))
    else
      page = nil
    end
  end
end
