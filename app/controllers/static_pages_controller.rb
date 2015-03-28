include StaticPagesHelper
class StaticPagesController < ApplicationController
  def home
  end

  def results
  	uri = URI(params[:url])
		@code_original = Net::HTTP.get(uri)
		@code_translated = run_translation(@code_original)
  end
end
