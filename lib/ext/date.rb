class Date
  def self.parse_safely(raw_date_time)
    begin
      self.parse raw_date_time
    rescue ArgumentError
      nil
    rescue TypeError
      nil
    end
  end
end