# frozen_string_literal: true

require 'http'

module Credence
  # Create a new configuration file for a project
  class CreateNewDocument
    def initialize(config)
      @config = config
    end

    def api_url
      @config.API_URL
    end

    def call(current_account:, project_id:, document_data:)
      config_url = "#{api_url}/projects/#{project_id}/documents"
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                    .post(config_url, json: document_data)

      response.code == 201 ? JSON.parse(response.body.to_s) : raise
    end
  end
end
