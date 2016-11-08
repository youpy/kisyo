# coding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe Kisyo::Daily do
  let(:date) {
    Date.parse('2016-11-02')
  }

  let(:location) {
    Kisyo::Location.new(44, 47662)
  }

  let(:daily) {
    Kisyo::Daily.new(location)
  }

  describe '#at' do
    let(:url) {
      'http://www.data.jma.go.jp/obd/stats/etrn/view/daily_s1.php?block_no=47662&day=01&month=11&prec_no=44&view=p1&year=2016'
    }

    context 'information is available' do
      before do
        stub_request(:get, url).
          to_return(:body => read_fixture_file('201611.html'))
      end

      it 'returns weather information for given day' do
        info = daily.at(date)

        expect(info.precipitation_total).to eql(1.5)
        expect(info.precipitation_hourly_max).to eql(1.0)
        expect(info.precipitation_10min_max).to eql(0.5)
        expect(info.precipitation_10min_max).to eql(0.5)
        expect(info.temperature_avg).to eql(10.9)
        expect(info.temperature_max).to eql(12.2)
        expect(info.temperature_min).to eql(8.6)
        expect(info.humidity_avg).to eql(68.0)
        expect(info.humidity_min).to eql(53.0)
        expect(info.day_length).to eql(0.0)
        expect(info.general_weather_condition_day).to eql('曇後時々雨')
        expect(info.general_weather_condition_night).to eql('雨時々曇')
      end
    end

    context 'information is not available' do
      before do
        stub_request(:get, url).
          to_return(:body => read_fixture_file('ng.html'))
      end

      it 'raises error' do
        expect {
          daily.at(date)
        }.to raise_error(Kisyo::Error, 'invalid date')
      end
    end
  end
end
