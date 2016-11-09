module Kisyo
  class Cache
    CACHE_SIZE = 100

    def initialize
      @keys = []
      @values = {}
    end

    def get(key)
      values[key]
    end

    def set(key, value)
      keys << key
      values[key] = value

      if keys.size > CACHE_SIZE
        oldest_key = keys.shift
        values.delete(oldest_key)
      end
    end

    private

    attr_reader :keys, :values
  end
end
