require 'rubygems'
require 'httpart'
require 'nokogiri'

class Google
  include HTTParty

  def self.translate(from_lang, to_lang, text)
    base_uri 'http://ajax.googleapis.com/ajax/services/language'
    return get('/translate?', :query => {:v => '1.0',
               :langpair => "#{from_lang}|#{to_lang}",
               :q => text})['responseData']['translatedText']
  end

  def self.suggestion(q, lang='en')
    base_uri 'http://www.google.com'
    page=Nokogiri::HTML(self.get('/search', :query => {
      :client => 'firefox-a',
      :rls => 'org.mozilla',
      :hs => 'pdz',
      :hl => 'en',
      :q => q,
      :meta => ''
    }))
    page.search('a').each do |l|
      return l.text if l[:href]=~/^\/search.*spell=1$/
    end
    return false
  end
end
