module Kisyo
  class Cache
    CACHE_SIZE = 100

    def initialize
      @keys = []
      @values = {}
      @m = Mutex.new
    end

    def get(key)
      values[key]
    end

    def set(key, value)
      m.synchronize do
        if values[key]
          return
        end

        keys << key
        values[key] = value

        if keys.size > CACHE_SIZE
          oldest_key = keys.shift
          values.delete(oldest_key)
        end
      end
    end

    private

    attr_reader :keys, :values, :m
  end
end
