module URI
  def self.parse_safely(raw_uri)
    begin
      URI.parse raw_uri
    rescue URI::InvalidURIError
      nil
    end
  end
end