# encoding: utf-8
include StaticPagesHelper
class StaticPagesController < ApplicationController
	before_action :set_uri, only: :results

  def home
    @languages = Language.all
  end

  def results
  	@extension = get_extension(@uri)
  	if @extension.empty?
  		redirect_to static_pages_invalid_url_path
  	else
  		@raw_uri = get_raw_uri(@uri)
			@code_original = Net::HTTP.get(@uri)
      language_code = Language.find(params[:language]).code
			@code_translated = run_translation(@code_original, @extension, language_code)
		end
  end

  def invalid_url
    @languages = Language.all
	end

	##############################################################################
  private
  	def set_uri
  		begin
	  		@uri = URI(params[:url])
	  	rescue URI::InvalidURIError
	  		redirect_to static_pages_invalid_url_path
	  	end
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
