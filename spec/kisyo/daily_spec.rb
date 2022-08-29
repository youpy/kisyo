# coding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe Kisyo::Daily do
  let(:date) { Date.parse('2016-11-02') }
  let(:location) { Kisyo::Location.new('44', '47662') }
  let(:daily) { Kisyo::Daily.new(location) }

  describe '#at' do
    let(:url) do
      'http://www.data.jma.go.jp/obd/stats/etrn/view/daily_s1.php?block_no=47662&day=01&month=11&prec_no=44&view=p1&year=2016'
    end

    let(:fixture_file_name) { '201611.html' }

    context 'single request' do
      before do
        stub_request(:get, url).to_return(
          body: read_fixture_file(fixture_file_name)
        )
      end

      context 'information is available' do
        it 'returns weather information for given day' do
          info = daily.at(date)

          expect(info.precipitation_total).to eql(1.5)
          expect(info.precipitation_hourly_max).to eql(1.0)
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
        let(:fixture_file_name) { 'ng.html' }

        it 'raises error' do
          expect { daily.at(date) }.to raise_error(
            Kisyo::WeatherInformationNotAvailable
          )
        end
      end

      context 'value is "--"' do
        let(:date) { Date.parse('2016-11-04') }

        it '"--" is converted to nil' do
          info = daily.at(date)

          expect(info.precipitation_total).to be_nil
          expect(info.precipitation_hourly_max).to be_nil
          expect(info.precipitation_10min_max).to be_nil
        end
      end
    end
    context 'multiple request' do
      before do
        stub_request(:get, url)
          .to_return(body: read_fixture_file(fixture_file_name))
          .times(number_of_request)
      end

      context '2016-11-01 - 2016-11-05' do
        let(:number_of_request) { 1 }

        it 'caches and reuses first response' do
          date = Date.parse('2016-11-01')

          expect(daily.at(date).precipitation_total).to eql(10.0)
          expect(daily.at(date + 1).precipitation_total).to eql(1.5)
          expect(daily.at(date + 2).precipitation_total).to eql(3.0)
          expect(daily.at(date + 3).precipitation_total).to be_nil
          expect(daily.at(date + 4).precipitation_total).to eql(0.0)

          expect(a_request(:get, url)).to have_been_made.times(1)
        end
      end
    end
  end
end
