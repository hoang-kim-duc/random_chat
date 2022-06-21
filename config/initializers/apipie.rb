# frozen_string_literal: true

Apipie.configure do |config|
  config.app_name                = 'RandomChat'
  config.api_base_url            = 'https://random-chat-api-server.herokuapp.com'
  config.doc_base_url            = '/docs'
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
