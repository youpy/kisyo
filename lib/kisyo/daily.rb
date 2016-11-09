require 'nokogiri'
require 'open-uri'

module Kisyo
  class Daily
    def initialize(location)
      @location = location
    end

    def at(date)
      url = 'http://www.data.jma.go.jp/obd/stats/etrn/view/daily_s1.php?prec_no=%i&block_no=%i&year=%i&month=%i&day=01&view=p1' % [
        @location.prefecture_id,
        @location.block_id,
        date.year,
        date.month
      ]

      content = open(url).read
      doc = Nokogiri::HTML(content)
      days = doc.css('div.a_print')

      raise WeatherInformationNotAvailable if days.size == 0

      days.each do |el|
        if el.text.to_i == date.day
          tr = el.parent.parent
          values = tr.css('td').map do |td|
            td.text
          end

          return Element::Day.new(*values[1 .. -1])
        end
      end
    end
  end
end
