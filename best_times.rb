require 'csv'
require 'date'

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

def best_hour (hash)
  hash.sort_by do |k,v| v end.reverse
end

hours = Hash.new(0)
weekday = Hash.new(0)

contents.each do |row|
  csv_contents = DateTime.strptime(row[1],'%m/%d/%Y %H:%M')
  hours[csv_contents.hour] += 1
  weekday[csv_contents.wday] += 1 
end 

sorted = best_hour(hours)
sorted_day = best_hour(weekday)

week = {'0':'Sunday','1':'Monday','2':'Tuesday','3':'Wednesday','4':'Thursday', '5':'Friday', '6':'Saturday'}
weekday = (sorted_day[0][0]).to_s.to_sym


File.open('best_times_to_advertise.txt', 'w') do |file|
file.puts "The best hour of the day to advertise is #{sorted[0][0]} and the best day is #{week[weekday]}."
end







