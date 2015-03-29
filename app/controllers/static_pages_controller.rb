# encoding: utf-8
include StaticPagesHelper
class StaticPagesController < ApplicationController
	before_action :set_uri, only: :results
  def home
  end

  def results
  	@extension = get_extension(@uri)
  	if @extension.empty?
  		redirect_to static_pages_invalid_url_path
  	else
  		@raw_uri = get_raw_uri(@uri)
			@code_original = Net::HTTP.get(@uri)
			@code_translated = run_translation(@code_original, @extension)
		end
  end

  def invalid_url
	end

	##############################################################################
  private
  	def set_uri
  		@uri = URI(params[:url])
  	end

  	def get_raw_uri(uri)
  		uri = uri.scheme + "://" + uri.host + uri.path
  		if uri.match(/(https:\/\/github.com\/)|(https:\/\/www.github.com\/)/)
  			uri.gsub!('github.com', 'raw.githubusercontent.com').gsub!('/blob', '')
  		elsif uri.match(/https:\/\/raw.githubusercontent.com\//)
			else
				redirect_to static_pages_invalid_url_path
			end
  		@uri = URI(uri)
  	end
end
