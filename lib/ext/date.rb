# frozen_string_literal: true

class Date
  def self.parse_safely(raw_date_time)
    parse raw_date_time
  rescue ArgumentError, TypeError
    nil
  end
end
