# myapp.rb
require 'sinatra'
require 'date'
require 'open-uri'
require 'nokogiri'

get '/' do
  erb :index
end

post '/' do
  @lang = params[:lang]
  @date = Date.parse(params[:date]) << 9
  
  #options = []
  #options << try_exact_date()
  #options << try_day_month()
  #options << try_month_year()
  #options << try_year_only()
  
  event = try_exact_date()
  "Most likely historical event that aroused your parents around #{@date}: #{event}"
end

get '/scrape' do
  
end

def try_exact_date
  from = (@date - 3).to_time.strftime("%Y%m%d")
  to = (@date + 3).to_time.strftime("%Y%m%d")
  url = "http://www.vizgr.org/historical-events/search.php?begin_date=#{from}&end_date=#{to}&lang=#{@lang}&granularity=all"
  puts url
  doc = Nokogiri::HTML(open(url))
  doc.xpath('//description')[0] 
end

def try_day_month
  
end

def try_month_year
  
end

def try_year_only
  
end

