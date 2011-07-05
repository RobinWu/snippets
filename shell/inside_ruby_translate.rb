# RubyTranslate provides a simple wrapper around the Google Translate API for detecting and translating languages
#
# Author:: Aimee Daniells (mailto:aimee@edendevelopment.co.uk)
# License:: MIT License

require 'net/http'
require 'uri'
require 'cgi'
require 'json'

module RubyTranslate
	def self.translate(text, to, from=nil)
		from = detect(text) if from.nil?
		json = run('translate', {:langpair => "#{from}|#{to}", :q => text})
		return json['responseData']['translatedText'] if json['responseStatus'] == 200
		raise StandardError, json['responseDetails']
	end

	def self.detect(text)
		json = run('detect', {:q => text})
		return json['responseData']['language'] if json['responseStatus'] == 200
		raise StandardError, json['responseDetails']
	end

	private

		def self.run(service, parameters)
			base = 'http://ajax.googleapis.com/ajax/services/language'
			parameters.merge!({:v => 1.0})
			query = parameters.map{|k,v| "#{k}=#{CGI.escape(v.to_s)}"}.join('&')
			response = Net::HTTP.get_response(URI.parse("#{base}/#{service}?#{query}")) 
			JSON.parse(response.body)
		end
end

RubyTranslate.run
