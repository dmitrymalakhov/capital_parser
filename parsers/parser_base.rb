# encoding: utf-8
require 'open-uri'

class ParserBase
	def initialize(store)
		@store = store
	end

	def get_status()
		return "OK"
	end

	def get_categories()
		@store.categories
	end

	def get_pavilions_by_store()
		@store.pavilions
	end
	def get_pavilions_by_category(category)
		category.pavilions
	end
	def get_brands_by_category(category)
		category.brands
	end
	def get_description_by_pavilion(pavilion)
		pavilion.pavilion_description
	end

	def get_news()
		@store.news
	end

	protected

	def get_document(path)
		begin
			doc = Nokogiri::HTML(open(path), nil, 'UTF-8')
			doc.xpath('//@style').remove
			doc.search('script').remove
			doc.encoding = 'UTF-8'
			
		rescue Errno::ETIMEDOUT
			puts "repeat query....."
			retry
		end

		return doc
	end
end