require 'rubygems'
require 'nokogiri'
require 'date'
require 'data_mapper'

class Event
  include DataMapper::Resource

  property :id,           Serial
  property :date,         Date,     :index => true
  property :description,  String
end

def main()
  DataMapper.setup(:default, "postgres://conception:Test1234@localhost/conception")
  DataMapper.auto_migrate!
  p "Start!"
  doc = Nokogiri::parse(open('/home/maarten/Documents/data/data.xml'))
  doc.xpath('//event').each do |event|
    begin
      date = Date.parse(event.xpath('date').text)
      description = event.xpath('description').text.strip()
      #dates[date] = [] unless dates[date]
      #dates[date] << description
      Event.create(:date => date, :description => description)
    rescue ArgumentError

    end
  end
  p "Done!"
  # a = dates.keys.first
  # b = Date.new(1900,1,1)
  # p a == b
  # p dates[Date.new(1900,1,1)]
  # (Date.new(1900,1,1)..Date.today).each do |d|
  # p d unless dates[d]
  # end
end

main()
