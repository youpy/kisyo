require 'csv'
require 'geocoder'

module Kisyo
  class Location
    attr_reader :prefecture_id, :block_id

    def self.distance(lat1, lng1, lat2, lng2)
      Geocoder::Calculations.distance_between([lat1, lng1], [lat2, lng2])
    end

    def self.dms_to_degrees(d, m, s = 0)
      d + m / 60.0 + s / 3600.0
    end

    def self.nearest(lat, lng)
      distances =
        BLOCKS.map do |block|
          la = dms_to_degrees(block[3].to_f, block[4].to_f)
          ln = dms_to_degrees(block[5].to_f, block[6].to_f)

          [distance(lat, lng, la, ln), block]
        end

      block = distances.min_by { |(dist, _)| dist }[1]

      new(block[1], block[2])
    end

    def initialize(prefecture_id, block_id)
      @prefecture_id = prefecture_id
      @block_id = block_id
    end
  end
end
