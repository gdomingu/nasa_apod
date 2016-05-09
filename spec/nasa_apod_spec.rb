require 'spec_helper'

module NasaApod

  describe Client do
    describe '#initialize' do
      let(:client) { Client.new }

      it 'api key defaults to DEMO_KEY' do
        expect(client.api_key).to eq("DEMO_KEY")
      end

      it 'date defaults to a string of today' do
        expect(client.date).to eq(Date.today.to_s)
      end
    end

    describe '#search' do
      let(:client) { Client.new }

      it 'returns results' do
        results = client.search(:date => Date.today.prev_day)
        expect(results.class).to eq(NasaApod::SearchResults)
      end

      it 'returns a date' do
        results = client.search(:date => Date.today.prev_day)
        expect(results.date).to eq(Date.today.prev_day.to_s)
      end

      it 'returns copyright' do
        results = client.search(:date => Date.today.prev_day)
        expect(results.copyright).to_not be(nil)
      end

      it 'changes picture when date changes' do
        results = client.search(:date => Date.today.prev_day)
        yesterdays_title = results.title
        results = client.search(:date => Date.today)
        todays_title = results.title
        expect(yesterdays_title).to_not eq(todays_title)
      end

      it 'returns a HD image with params' do
        results = client.search(:date => Date.parse("2016-05-08"), :hd => true)
        expect(results.hd_url).to_not  be(nil)
      end
    end

    describe '#random_post' do
      let(:client) { Client.new }

      it 'returns a random post within apod range' do
        results = client.random_post 
        expect(results.class).to eq(NasaApod::SearchResults)
        expect(Date.parse(client.date)).to be_between(Date.parse("1995-06-16"),Date.today)
      end
    end

  end

  describe SearchResults do
    describe '#initialize' do
      let(:result) { SearchResults.new(attributes) }
      let(:attributes) {{"url" =>  "test_url",
                        "media_type" =>  "JPG",
                        "title" =>  "Test title",
                        "explanation" => "Test explanation",
                        "date" => "1995-06-16"
                        }}

      it 'assigns all attributes properly' do
        attributes.keys.each do |attr|
          expect(result.send(attr)).to eq(attributes[attr])
        end
      end
    end

    describe "#thumbnail_url" do
      context 'when media_type is video' do
        let(:result) { SearchResults.new(attributes) }
        let(:attributes) {{"url" =>  "https://www.youtube.com/embed/3LdZ_NftIh8?rel=0",
                        "media_type" =>  "video",
                        "title" =>  "Test title",
                        "explanation" => "Test explanation",
                        "date" => "1995-06-16"
                        }}

        it 'returns a image url' do
          expect(result.thumbnail_url).to eq('http://img.youtube.com/vi/3LdZ_NftIh8/sddefault.jpg')
        end
      end
      context 'when media_type is image' do
        let(:result) { SearchResults.new(attributes) }
        let(:attributes) {{"url" =>  "http://img.youtube.com/vi/3LdZ_NftIh8/sddefault.jpg",
                        "media_type" =>  "image",
                        "title" =>  "Test title",
                        "explanation" => "Test explanation",
                        "date" => "1995-06-16"
                        }}

        it 'returns a image url' do
          expect(result.thumbnail_url).to eq('http://img.youtube.com/vi/3LdZ_NftIh8/sddefault.jpg')
        end
      end
    end
  end

  describe Error do
    describe '#initialize' do
      let(:result) { Error.new(error_reponse) }
      let(:error_reponse) {HTTParty.get("https://api.nasa.gov/planetary/apod")}

      it 'knows what went wrong' do
        expect(error_reponse.code).to eq(403)
      end
    end
  end
end