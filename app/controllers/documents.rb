# frozen_string_literal: true

require 'roda'
require_relative './app'

module Credence
  # Web controller for Credence API
  class App < Roda
    route('documents') do |routing|
      routing.redirect '/auth/login' unless @current_account.logged_in?

      # GET /documents/[doc_id]
      routing.get(String) do |doc_id|
        doc_info = GetDocument.new(App.config)
                              .call(@current_account, doc_id)
        document = Document.new(doc_info)

        view :document, locals: {
          current_account: @current_account, document: document
        }
      end
    end
  end
end
