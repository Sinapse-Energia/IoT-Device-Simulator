class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :terms
  layout 'application'

  def terms; end

end
