# NasaApod

A Ruby gem for consuming the NASA Astronomy Picture of the Day API. 

## Installation

Add this line to your application's Gemfile:

    gem 'nasa_apod'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nasa_apod

## Usage

Search by date:
```
client = NasaApod::Client.new(api_key: "DEMO_KEY") #DEMO_KEY usage is limited.
result = client.search(date: "2015-06-18") #You can also pass in a Ruby Date object. 
result
```

Get title:

```
result = client.search
result.title #=> "M64: The Black Eye Galaxy"
```

Get explanation:

```
result = client.search
result.explanation #=> "This big, bright, beautiful spiral galaxy is Messier 64..."
```

Get concept tags with result
```
result = client.search(concept_tags: true) 
result.concepts #=> ["Sun","Sunspot","Light",...],
```
Note: Not all posts have concept tags.

Get image URL:

```
result = client.search
result.url #=> "http://apod.nasa.gov/apod/image/1506/CeresMountain_Dawn_1041.jpg"
```

Get HD image URL:

```
result = client.search(hd: true) 
result.hd_url #=> "http://apod.nasa.gov/apod/image/1506/CeresMountain_Dawn_1041.jpg"
```

Random post:
```
result = client.wormhole
result
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/nasa_apod/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
