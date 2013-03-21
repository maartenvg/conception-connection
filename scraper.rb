require 'nokogiri'
require 'date'

def main()
  doc = Nokogiri::parse(open('/home/maarten/Documents/data/data.xml'))
  dates = {}
  doc.xpath('//event').each do |event|
    begin
      date = Date.parse(event.xpath('date').text)
      description = event.xpath('description').text
      dates[date] = [] unless dates[date]
      dates[date] << description
    rescue
      
    end
  end
  p dates.length
  a = dates.keys.first
  b = Date.new(1900,1,1)
  p a == b
  p dates[Date.new(1900,1,1)]
  (Date.new(1900,1,1)..Date.today).each do |d|
    p d unless dates[d]
  end
end

main()
