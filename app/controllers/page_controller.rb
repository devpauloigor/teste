class PageController < ApplicationController
   before_filter :authenticate_user!
  def index
    render params[:id]
  end

	
end
