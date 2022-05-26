# frozen_string_literal: true

require 'http'

module Credence
  # Returns an authenticated user, or nil
  class AuthenticateAccount
    class UnauthorizedError < StandardError; end

    class ApiServerError < StandardError; end

    def initialize(config)
      @config = config
    end

    def call(username:, password:)
      response = HTTP.post("#{@config.API_URL}/auth/authenticate",
                           json: { username:, password: })

      raise(UnauthorizedError) if response.code == 403
      raise(ApiServerError) if response.code != 200

      account_info = JSON.parse(response.to_s)['data']['attributes']

      {
        account: account_info['account'],
        auth_token: account_info['auth_token']
      }
    end
  end
end
