# frozen_string_literal: true

require 'dry-validation'

module Credence
  # Form helpers
  module Form
    USERNAME_REGEX = /^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*$/.freeze
    EMAIL_REGEX = /@/.freeze
    FILENAME_REGEX = %r{^((?![&\/\\\{\}\|\t]).)*$}.freeze
    PATH_REGEX = /^((?![&\{\}\|\t]).)*$/.freeze

    def self.validation_errors(validation)
      validation.errors.to_h.map { |k, v| [k, v].join(' ') }.join('; ')
    end

    def self.message_values(validation)
      validation.errors.to_h.values.join('; ')
    end
  end
end
