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
        @precipitation_total = precipitation_total.to_f
        @precipitation_hourly_max = precipitation_hourly_max.to_f
        @precipitation_10min_max = precipitation_10min_max.to_f
        @temperature_avg = temperature_avg.to_f
        @temperature_max = temperature_max.to_f
        @temperature_min = temperature_min.to_f
        @humidity_avg = humidity_avg.to_f
        @humidity_min = humidity_min.to_f
        @day_length = day_length.to_f
        @general_weather_condition_day = general_weather_condition_day
        @general_weather_condition_night = general_weather_condition_night
      end
    end
  end
end
