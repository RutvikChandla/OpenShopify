class RandomController < ApplicationController
  prepend_view_path SqlTemplate::Resolver.new

  def index
    render locals: { "name" => @current_shop.name }
  end
end
