module Kisyo
  module Element
    class Day
      attr_reader(
        :precipitation_total,
        :precipitation_hourly_max,
        :precipitation_10min_max,
        :temperature_avg,
        :temperature_max,
        :temperature_min,
        :humidity_avg,
        :humidity_min,
        :day_length,
        :general_weather_condition_day,
        :general_weather_condition_night
      )

      def initialize(
            _, _,
            precipitation_total,
            precipitation_hourly_max,
            precipitation_10min_max,
            temperature_avg,
            temperature_max,
            temperature_min,
            humidity_avg,
            humidity_min,
            _, _, _, _, _,
            day_length,
            _, _,
            general_weather_condition_day,
            general_weather_condition_night
          )
        @precipitation_total = convert_value(precipitation_total)
        @precipitation_hourly_max = convert_value(precipitation_hourly_max)
        @precipitation_10min_max = convert_value(precipitation_10min_max)
        @temperature_avg = convert_value(temperature_avg)
        @temperature_max = convert_value(temperature_max)
        @temperature_min = convert_value(temperature_min)
        @humidity_avg = convert_value(humidity_avg)
        @humidity_min = convert_value(humidity_min)
        @day_length = convert_value(day_length)
        @general_weather_condition_day = general_weather_condition_day
        @general_weather_condition_night = general_weather_condition_night
      end

      def convert_value(value)
        case value
        when '--'
          nil
        else
          value.to_f
        end
      end
    end
  end
end
