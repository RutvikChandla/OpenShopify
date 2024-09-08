class ApplicationController < ActionController::Base
  before_action :find_shop_by_domain
  attr_reader :current_shop

  private

  def find_shop_by_domain
    @current_shop = Shop.find_by(domain: request.subdomain)
    puts "request.domain: #{request.domain}"
  end
end
