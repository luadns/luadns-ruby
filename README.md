# LuaDNS Ruby Client

This is the Ruby client for [LuaDNS REST API](https://www.luadns.com/api.html).


[![Build Status](https://github.com/luadns/luadns-ruby/actions/workflows/ci.yml/badge.svg)](https://github.com/luadns/luadns-ruby/actions/workflows/ci.yml)


## Installation

Add to Gemfile

```ruby
gem "luadns", "~> 0.1"
```


## Usage

Initialize the client using the account email and API key:


```ruby
require "luadns"

# Init the client with your email and API key.
client = Luadns::Client.new("joe@example.com", "api_key")
```

Getting current user:

```ruby
client.users.me
```

Working with zones:

```ruby
# List current zones
client.zones.list_zones

# Create a new zone
client.zones.create_zone({name: "example.dev"})

# Get a zone
client.zones.get_zone(zone_id)

# Update a zone
client.zones.update_zone(zone.id, attributes)

# Delete a zone
client.zones.delete_zone(zone.id)
```

Working with records:

```ruby
# List zone records
client.records.list_records

# Create a new record
client.records.create_record(zone, {
  name: "example.org.",
  type: "TXT",
  content: "Hello, world!",
  ttl: 3600
})

# Get a record
client.records.get_record(zone, record_id)

# Update a record
client.records.update_record(zone, record.id, {
  name: "example.org.",
  type: "TXT",
  content: "Aloha!",
  ttl: 3600
})

# Delete a record
client.records.delete_record(zone, record.id)
```

## Rate Limits

The API requests are [rate-limited](http://www.luadns.com/api.html#rate-limiting),
 the request should be retried later when `Luadns::RateLimitError` is raised:

```ruby
begin
    client.list_zones
rescue Luadns::RateLimitError => e
    sleep e.reset_in
    retry
end
```


## Rails

The library can be initialized using ENV variables from a Rails initializer.

Example:

```ruby
# config/initializers/luadns.rb
Luadns.configure do |config|
  config.username = ENV['LUADNS_USERNAME']
  config.password = ENV['LUADNS_API_KEY']
end
```

## Support and Feedback

Be sure to visit the LuadDNS official [documentation website](http://www.luadns.com/api.html) for additional information about our API.
