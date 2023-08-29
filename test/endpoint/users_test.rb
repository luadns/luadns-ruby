# frozen_string_literal: true

require "test_helper"

class Luadns::Endpoint::UsersTest < Luadns::Test
  def setup
    @client = Luadns::Client.new("username", "password")
  end

  it "returns current users infor" do
    stub_request(:get, "https://api.luadns.com/v1/users/me")
      .to_return(read_http_fixture("test/fixtures/http/users/me.show"))

    user = @client.users.me

    assert_equal "joe@example.com", user.email
    assert_equal "Example User", user.name
    assert_equal "", user.repo_uri
    assert user.api_enabled
    refute user.tfa
    assert_match(/ssh-rsa AAAA/, user.deploy_key)
    assert_equal 300, user.ttl
    assert_equal "Free", user.package
    assert_equal %w[ns1.luadns.net. ns2.luadns.net. ns3.luadns.net. ns4.luadns.net.], user.name_servers
  end
end
