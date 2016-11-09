require 'nokogiri'
require 'open-uri'

module Kisyo
  class Daily
    CACHE_SIZE = 100

    def initialize(location)
      @location = location
      @cache = Cache.new
    end

    def at(date)
      key = [date.year, date.month, date.day].join(',')

      if value = cache.get(key)
        return value
      end

      url = 'http://www.data.jma.go.jp/obd/stats/etrn/view/daily_s1.php?prec_no=%i&block_no=%i&year=%i&month=%i&day=01&view=p1' % [
        location.prefecture_id,
        location.block_id,
        date.year,
        date.month
      ]

      content = open(url).read
      doc = Nokogiri::HTML(content)
      days = doc.css('div.a_print')

      raise WeatherInformationNotAvailable if days.size == 0

      days.each do |el|
        tr = el.parent.parent
        values = tr.css('td').map(&:text)

        k = [date.year, date.month, values[0]].join(',')
        cache.set(k, Element::Day.new(*values[1 .. -1]))
      end

      cache.get(key)
    end

    private

    attr_reader :cache, :location
  end
end
