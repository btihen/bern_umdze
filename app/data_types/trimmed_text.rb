# frozen_string_literal: true

# trims leading & trailing white space - and retains tabs & new lines
class TrimmedText < ActiveRecord::Type::String
  def cast(value)
    value.to_s.strip
  end
end

# TEXT FIELD INPUTS
# https://blog.arkency.com/2016/03/custom-typecasting-with-activerecord-virtus-and-dry-types/

# add to: config/initializers/types.rb
# ActiveModel::Type.register(:trimmed_text, TrimmedText)
# usage:
# attribute :title, :trimmed_text, default: ''
