# coding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe Kisyo::Location do
  describe '.nearest' do
    it 'returns the location closest to the specified latitude and longitude' do
      loc = Kisyo::Location.nearest(35.6809591, 139.7673068)

      expect(loc.prefecture_id).to eql('44')
      expect(loc.block_id).to eql('47662')
    end
  end
end
