# removes leading & trailing spaces and removes duplicate internal spaces
class SquishedString < ActiveRecord::Type::String
  def cast(value)
    value.to_s.squish
  end
end

# STRING FIELD INPUTS
# squish handles unicode & turns tabs & line returns into a space
# https://blog.arkency.com/2016/03/custom-typecasting-with-activerecord-virtus-and-dry-types/

# add to: config/initializers/types.rb
# ActiveModel::Type.register(:squished_string, SquishedString)
# usage:
# attribute :title, :squished_string, default: ''
