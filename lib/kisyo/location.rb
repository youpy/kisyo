module Kisyo
  class Location
    attr_reader :prefecture_id, :block_id

    def initialize(prefecture_id, block_id)
      @prefecture_id = prefecture_id
      @block_id = block_id
    end
  end
end
