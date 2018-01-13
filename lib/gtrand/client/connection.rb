module Gtrand
  class Client
    module Connection
      def get(path, options = {})
        request :get, path, options
      end

      private

      def request(http_method, path, options)
        response = self.class.send(http_method, path, query: payload(options))
        parse_data(response.body)
      end

      def parse_data(original_data)
        return unless original_data

        data = original_data

        JSON.parse(data.gsub(/\)\]\}',?/, ''))
      end

      def payload(options)
        widget_id = options.delete(:widget_id)
        return options unless widget_id

        widget = widgets[widget_id].last

        data = {
            tz: '-180',
            hl: widget.dig('request', 'locale'),
            req: widget.dig('request'),
            token: widget.dig('token')
          }
        options.merge!(data)
      end
    end
  end
end
