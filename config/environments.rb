# frozen_string_literal: true

require 'delegate'
require 'roda'
require 'figaro'
require 'logger'
require 'rack/ssl-enforcer'
require 'rack/session/redis'
require_relative '../require_app'

require_app('lib')

module Credence
  # Configuration for the API
  class App < Roda
    plugin :environments

    # Environment variables setup
    Figaro.application = Figaro::Application.new(
      environment:,
      path: File.expand_path('config/secrets.yml')
    )
    Figaro.load
    def self.config = Figaro.env

    # Logger setup
    LOGGER = Logger.new($stderr)
    def self.logger = LOGGER

    ONE_MONTH = 30 * 24 * 60 * 60

    configure do
      SecureMessage.setup(ENV.delete('MSG_KEY'))
    end

    configure :production do
      SecureSession.setup(ENV.fetch('REDIS_TLS_URL')) # REDIS_TLS_URL used again below

      use Rack::SslEnforcer, hsts: true

      use Rack::Session::Redis,
          expire_after: ONE_MONTH,
          redis_server: {
            url: ENV.delete('REDIS_TLS_URL'),
            ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
          }
    end

    configure :development, :test do
      require 'pry'

      # NOTE: env var REDIS_URL only used to wipe the session store (ok to be nil)
      SecureSession.setup(ENV.fetch('REDIS_URL', nil)) # REDIS_URL used again below

      # use Rack::Session::Cookie,
      #     expire_after: ONE_MONTH, secret: config.SESSION_SECRET

      use Rack::Session::Pool,
          expire_after: ONE_MONTH

      # use Rack::Session::Redis,
      #     expire_after: ONE_MONTH,
      #     redis_server: ENV.delete('REDIS_URL')

      # Allows running reload! in pry to restart entire app
      def self.reload! = exec 'pry -r ./spec/test_load_all'
    end
  end
end
