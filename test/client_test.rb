# frozen_string_literal: true

require "test_helper"

class Luadns::ClientTest < Luadns::Test
  def setup
    @client = Luadns::Client.new("username", "password")
  end

  it "sets accept header to application/json" do
    stub_request(:get, "https://api.luadns.com/v1/users/me")
      .with({headers: {"Accept" => "application/json"}})
      .to_return(read_http_fixture("test/fixtures/http/users/me.show"))

    @client.users.me
  end

  it "uses basic access authentication" do
    stub_request(:get, "https://api.luadns.com/v1/users/me")
      .with({headers: {"Authorization" => "Basic dXNlcm5hbWU6cGFzc3dvcmQ="}})
      .to_return(read_http_fixture("test/fixtures/http/users/me.show"))

    @client.users.me
  end

  it "sets custom user-agent header" do
    stub_request(:get, "https://api.luadns.com/v1/users/me")
      .with({headers: {"User-Agent" => "luadns-ruby/#{Luadns::VERSION}"}})
      .to_return(read_http_fixture("test/fixtures/http/users/me.show"))

    @client.users.me
  end

  it "raises exception when server when authentication fails" do
    stub_request(:get, "https://api.luadns.com/v1/users/me")
      .to_return(read_http_fixture("test/fixtures/http/users/me.show:err-bad-key"))

    error = assert_raises Luadns::AuthenticationError do
      @client.users.me
    end

    assert_equal 401, error.http_status
    assert_equal "Invalid API Key", error.message
  end

  it "raises exception when accept header is missing" do
    stub_request(:get, "https://api.luadns.com/v1/users/me")
      .to_return(read_http_fixture("test/fixtures/http/users/me.show:err-bad-accept"))

    error = assert_raises Luadns::RequestError do
      @client.users.me
    end

    assert_equal 403, error.http_status
    assert_equal "Invalid 'Accept' header", error.message
  end

  it "raises exception when server returns bad status code" do
    stub_request(:get, "https://api.luadns.com/v1/users/me")
      .to_return(read_http_fixture("test/fixtures/http/users/me.show:err-bad-code"))

    error = assert_raises Luadns::ServerError do
      @client.users.me
    end

    assert_equal 502, error.http_status
  end

  it "raises exception when server returns bad content type" do
    stub_request(:get, "https://api.luadns.com/v1/users/me")
      .to_return(read_http_fixture("test/fixtures/http/users/me.show:err-bad-content"))

    error = assert_raises Luadns::ServerError do
      @client.users.me
    end

    assert_equal "text/html", error.http_headers["Content-Type"]
  end

  it "raises exception when server returns 429 status code" do
    stub_request(:get, "https://api.luadns.com/v1/users/me")
      .to_return(read_http_fixture("test/fixtures/http/users/me.show:err-too-many"))

    error = assert_raises Luadns::RateLimitError do
      @client.users.me
    end

    assert_equal 1_693_221_300, error.reset_at
  end
end
