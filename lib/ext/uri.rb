# frozen_string_literal: true

module URI
  def self.parse_safely(raw_uri)
    URI.parse raw_uri
  rescue URI::InvalidURIError
    nil
  end
end
