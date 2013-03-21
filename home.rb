# myapp.rb
require 'sinatra'
require 'date'
require 'open-uri'
require 'nokogiri'
require 'data_mapper'

class Event
  include DataMapper::Resource

  property :id,           Serial
  property :date,         Date,     :index => true
  property :description,  String ,  :length => 250
end

DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, "postgres://conception:Test1234@localhost/conception")

get '/' do
  erb :index
end

post '/' do
  begin
    date = Date.parse(params[:date]) << 9

    event = Event.all(:date.lte => date, :date.gt => date - 14, :order => [ :date.desc ])[0]
    if event
      "Most likely historical event that aroused your parents<br /> #{event[:date]}: #{event[:description]}"
    else
      "Nothing significant happend in the two weeks before your conception around #{date}."
    end
  rescue ArgumentError
    halt 500, 'Illegal date'
  end
end
