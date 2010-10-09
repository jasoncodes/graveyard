# Monday, 11th October 2010
Date::DATE_FORMATS[:long_human] = lambda { |date| date.strftime("%A, #{ActiveSupport::Inflector.ordinalize(date.day)} %B %Y") }
# Mon 11 Oct
Date::DATE_FORMATS[:short_human] = "%a %d %b"
