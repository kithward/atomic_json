# frozen_string_literal: true

module AtomicJson
  module JsonQueryHelpers

    def jsonb_quote_keys(keys)
      "'{#{keys.map(&:to_s).join(',')}}'"
    end

    def jsonb_quote_value(value)
      # make sure to escape single quotes so that psql doesn't complain (double them up)
      %('#{value.to_json.to_str.gsub("'", "''")}')
    end

    def concatenation(target, keys, value)
      "#{target}->#{keys.map { |x| quote(x) }.join('->')} || #{jsonb_quote_value(value)}"
    end

  end
end
