require 'csv'

module Kisyo
  class Location
    attr_reader :prefecture_id, :block_id

    def self.dms_to_degrees(d, m, s = 0)
      d + m / 60.0 + s / 3600.0
    end

    def self.nearest(lat, lng)
      CSV.open(File.dirname(__FILE__) + '/../blocks.csv') do |csv|
        distances =
          csv.map do |row|
            la = dms_to_degrees(row[5].to_f, row[6].to_f)
            ln = dms_to_degrees(row[7].to_f, row[8].to_f)

            [Math.sqrt((lat - la)**2 + (lng - ln)**2), row]
          end

        distance = distances.min_by { |(dist, _)| dist }
        row = distance[1]

        new(row[3], row[4])
      end
    end

    def initialize(prefecture_id, block_id)
      @prefecture_id = prefecture_id
      @block_id = block_id
    end
  end
end
