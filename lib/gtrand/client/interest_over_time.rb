module Gtrand
  class Client
    module InterestOverTime
      def interest_over_time(options = {})
        options[:widget_id] = 'TIMESERIES'
        get('/widgetdata/multiline', options)
      end
    end
  end
end
