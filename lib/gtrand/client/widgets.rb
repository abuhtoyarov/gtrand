module Gtrand
  class Client
    module Widgets
      def all_widgets(options)
        response = get('/explore', widgets_payload(options))
        response.fetch('widgets', []).group_by { |w| w['id'] }
      end

      private

      def widgets_payload(options)
        keyword = options.delete(:keyword)

        raise 'The keyword must be passed' unless keyword

        hl = options.delete(:hl) || 'en'
        tz = options.delete(:tz) || '-180'
        date = options.delete(:date) || 'now 1-d'
        property = options.delete(:property) || ''
        category = options.delete(:category) || 0

        data = {
          hl: hl,
          tz: tz,
          req: {
            comparisonItem: [
              {
                keyword: keyword,
                geo: '',
                time: date
              }
            ],
            category: category,
            property: property
          }.to_json
        }
        options.merge(data)
      end
    end
  end
end
