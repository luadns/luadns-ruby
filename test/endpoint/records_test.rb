# frozen_string_literal: true

require "test_helper"

class Luadns::Endpoint::RecordsTest < Luadns::Test
  def setup
    @client = Luadns::Client.new("username", "password")
  end

  def zone
    Luadns::Schema::Zone.new(id: 5)
  end

  it "should list records" do
    stub_request(:get, "https://api.luadns.com/v1/zones/5/records")
      .to_return(read_http_fixture("test/fixtures/http/zones/5/records.index"))

    records = @client.records.list_records(zone)

    assert_equal 11, records.size

    record = records.first

    assert_equal 115_014_343, record.id
    assert_equal "example.org.", record.name
    assert_equal "ns1.luadns.net. hostmaster.luadns.net. 1692975563 1200 120 604800 3600", record.content
    assert_equal 3600, record.ttl
  end

  it "should create a new record" do
    stub_request(:post, "https://api.luadns.com/v1/zones/5/records")
      .to_return(read_http_fixture("test/fixtures/http/zones/5/records.create"))

    record = @client.records.create_record(zone,
      {name: "example.org.", type: "TXT", content: "Hello, world!", ttl: 3600})

    assert_equal 115_087_858, record.id
    assert_equal "example.org.", record.name
    assert_equal "Hello, world!", record.content
    assert_equal 3600, record.ttl
  end

  it "should get record" do
    stub_request(:get, "https://api.luadns.com/v1/zones/5/records/115014348")
      .to_return(read_http_fixture("test/fixtures/http/zones/5/records/115014348.show"))

    record = @client.records.get_record(zone, 115_014_348)

    assert_equal 115_014_348, record.id
    assert_equal "example.org.", record.name
    assert_equal "1.1.1.1", record.content
    assert_equal 86_400, record.ttl
  end

  it "should update record" do
    stub_request(:put, "https://api.luadns.com/v1/zones/5/records/115014348")
      .to_return(read_http_fixture("test/fixtures/http/zones/5/records/115014348.update"))

    record = @client.records.update_record(zone, 115_014_348, {name: "example.org.", content: "2.2.2.2", ttl: 3600})

    assert_equal 115_014_348, record.id
    assert_equal "example.org.", record.name
    assert_equal "2.2.2.2", record.content
    assert_equal 86_400, record.ttl
  end

  it "should delete record" do
    stub_request(:delete, "https://api.luadns.com/v1/zones/5/records/115014348")
      .to_return(read_http_fixture("test/fixtures/http/zones/5/records/115014348.delete"))

    record = @client.records.delete_record(zone, 115_014_348)

    assert_equal 115_014_348, record.id
    assert_equal "example.org.", record.name
    assert_equal "1.1.1.1", record.content
    assert_equal 86_400, record.ttl
  end
end
