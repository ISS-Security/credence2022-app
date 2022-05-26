# frozen_string_literal: true

require 'http'

module Credence
  # Returns all projects belonging to an account
  class GetDocument
    def initialize(config)
      @config = config
    end

    def call(user, doc_id)
      response = HTTP.auth("Bearer #{user.auth_token}")
                    .get("#{@config.API_URL}/documents/#{doc_id}")

      response.code == 200 ? JSON.parse(response.body.to_s)['data'] : nil
    end
  end
end
