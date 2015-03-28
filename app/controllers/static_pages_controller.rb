class StaticPagesController < ApplicationController
  def home
  end

  def results
  	uri = URI(params[:url])
		@string = Net::HTTP.get(uri)
  end
end
