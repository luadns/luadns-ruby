# frozen_string_literal: true

require "test_helper"

class Luadns::Endpoint::ZonesTest < Luadns::Test
  def setup
    @client = Luadns::Client.new("username", "password")
  end

  it "should list zones" do
    stub_request(:get, "https://api.luadns.com/v1/zones")
      .to_return(read_http_fixture("test/fixtures/http/zones.index"))

    zones = @client.zones.list_zones

    assert_equal 1, zones.size

    zone = zones.first

    assert_equal 5, zone.id
    assert_equal "example.org", zone.name
  end

  it "should create new zone" do
    stub_request(:post, "https://api.luadns.com/v1/zones")
      .to_return(read_http_fixture("test/fixtures/http/zones.create"))

    zone = @client.zones.create_zone({name: "example.dev"})

    assert_equal 75_247, zone.id
    assert_equal "example.dev", zone.name

    stub_request(:post, "https://api.luadns.com/v1/zones")
      .to_return(read_http_fixture("test/fixtures/http/zones.create:err-forbidden"))

    error = assert_raises Luadns::RequestError do
      zone = @client.zones.create_zone({name: "example.org"})
    end

    assert_equal "Zone 'example.org' is taken already.", error.message

    stub_request(:post, "https://api.luadns.com/v1/zones")
      .to_return(read_http_fixture("test/fixtures/http/zones.create:err-validation"))

    error = assert_raises Luadns::ValidationError do
      zone = @client.zones.create_zone({name: "%example.org"})
    end

    assert_equal 400, error.http_status
    assert_match(/invalid name/, error.message)
  end

  it "should get zone" do
    stub_request(:get, "https://api.luadns.com/v1/zones/5")
      .to_return(read_http_fixture("test/fixtures/http/zones/5.show"))

    zone = @client.zones.get_zone(5)

    assert_equal 5, zone.id
    assert_equal "example.org", zone.name
  end

  it "should update zone" do
    stub_request(:put, "https://api.luadns.com/v1/zones/5")
      .to_return(read_http_fixture("test/fixtures/http/zones/5.update"))

    zone = @client.zones.update_zone(5, {name: "example.org"})

    assert_equal 5, zone.id
    assert_equal "example.org", zone.name
  end

  it "should delete zone" do
    stub_request(:delete, "https://api.luadns.com/v1/zones/5")
      .to_return(read_http_fixture("test/fixtures/http/zones/5.delete"))

    zone = @client.zones.delete_zone(5)

    assert_equal 5, zone.id
    assert_equal "example.org", zone.name
  end
end
