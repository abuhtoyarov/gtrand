require 'gtrand/client/connection'
require 'gtrand/client/widgets'
require 'gtrand/client/interest_over_time'

module Gtrand
  class Client
    include HTTParty
    include Gtrand::Client::Connection
    include Gtrand::Client::Widgets
    include Gtrand::Client::InterestOverTime

    attr_reader :widgets

    base_uri 'https://trends.google.ru/trends/api'
    format :json

    query_string_normalizer proc { |query|
      query.map do |key, value|
        "#{key}=#{value}"
      end.join('&')
    }

    def initialize(options)
      @widgets = all_widgets(options)
    end
  end
end
