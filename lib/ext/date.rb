class Date
  def self.parse_safely(raw_date)
    begin
      Date.parse raw_date
    rescue ArgumentError
      nil
    rescue TypeError
      nil
    end
  end
end