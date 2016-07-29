class PagesController < ApplicationController
  before_filter :authenticate_user!

  def index

  		@usuario= User.all



  end

end