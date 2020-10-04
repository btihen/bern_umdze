# frozen_string_literal: true
require 'csv'

# https://makandracards.com/makandra/1307-how-to-use-helper-methods-inside-a-model
class ViewBase < ActionView::Base

  include ActiveModel::Model
  include ActiveModel::Serializers::JSON

  # html helpers
  # this works: https://stackoverflow.com/questions/12109047/is-it-possible-to-use-rails-image-tag-from-inside-a-model
  include ActionView::Helpers
  include ActionView::Helpers::AssetTagHelper
  # alternate way is to use the full path:
  # ActionController::Base.helpers.image_tag("image.png")

  # url_helpers
  # https://makandracards.com/makandra/1511-how-to-use-rails-url-helpers-in-any-ruby-class
  delegate :url_helpers, to: 'Rails.application.routes'

  attr_reader :view_context, :root_model

  # following ONLY works when root_model has its own route
  # def root_model_path
  #   url_helpers.send("#{root_model.class.model_name.param_key}_path".to_sym, root_model)
  # end
  # def root_model_url
  #   url_helpers.send("#{root_model.class.model_name.param_key}_url".to_sym, root_model)
  # end
  # for scoped routes do:
  # def group_show_url
  #   url_helpers.challengers_group_boards_path(group)
  # end
  # for nested routes (or to send parameters do):
  # def space_path
  #   url_helpers.tenant_space_path(space_id: space.id, id: id)
  # end

  # Models inherits from ` ActiveRecord::Base` which already define the following methods:
  # `to_param` and `model_name` which are needed for `link_to`
  # `id` is just important to have for the view to render the model properly
  # `to_partial_path` is required for the view to `render` collections properly
  # figure out how to point to the ROOT_MODEL of the View Object instance
  delegate :id, :to_param, :model_name, :to_partial_path, to: :root_model

  def initialize(root_model, view_context=nil)
    @view_context = view_context
    @root_model   = root_model #|| NoModel.new
  end

  # Initialize collection
  def self.collection(collection, view_context=nil)
    return []   if collection.blank?

    collection.map { |root_model| self.new(root_model, view_context) }
  end

  # export as CSV -- for
  # http://railscasts.com/episodes/362-exporting-csv-and-excel?view=asciicast
  def self.collection_to_csv(view_collection, attribs_list)
    CSV.generate do |csv|
      csv << attribs_list
      view_collection.each do |view_object|
        # get use values_at instead of map - still works
        # csv << view_object.root_model.attributes.values_at(*attribs_list)
        # get attributes directly (works with view objects)
        # csv << view_object.user.root_model.attributes.map { |k,v| v.to_s if %w[id username order_key].include?(k) }.compact
        # get info from value_object methods
        csv << attribs_list.map { |method| value_object.send(method.to_sym) }
      end
    end
  end

end
