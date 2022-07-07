# frozen_string_literal: true

# Initial code taken from Facets gem by Rubyworks
# https://github.com/rubyworks/facets/blob/master/lib/core/facets/string/snakecase.rb

class String
  # Underscore a string such that camelcase, dashes and spaces are
  # replaced by underscores.
  def snakecase_upcase
    split('::').last.
      gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
      gsub(/([a-z\d])([A-Z])/, '\1_\2').
      tr('-', '_').
      gsub(/\s/, '_').
      gsub(/__+/, '_').
      upcase
  end
end
