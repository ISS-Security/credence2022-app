# frozen_string_literal: true

require 'http'

module Credence
  # Returns all projects belonging to an account
  class GetProject
    def initialize(config)
      @config = config
    end

    def call(current_account, proj_id)
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                    .get("#{@config.API_URL}/projects/#{proj_id}")

      response.code == 200 ? JSON.parse(response.body.to_s)['data'] : nil
    end
  end
end
