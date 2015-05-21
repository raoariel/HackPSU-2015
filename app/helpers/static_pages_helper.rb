# encoding: utf-8
module StaticPagesHelper
	
	def get_extension(uri)
		File.extname(uri.path)
	end


	# Still need multiline 
	def run_translation(code_original, extension, language_code)
		code_translated = code_original
		translator = MicrosoftTranslator::Client.new('GitATranslation', 'cwzLCkrF5eAIejqfZn8zx/QkDBESQMzo/OO/gzBRGtU=')
		if extension == '.py'
			code_original.split(/(#(.*)\n)|("""(.*)""")/).each do |x|
				if x[0] == "#"
					language = translator.detect(x)
					translated = "#" + translator.translate(x,language, language_code,"text/html") + "\n"
					code_translated.gsub!(x, translated)
				# @TODO does not handle multiline comment
				elsif x.include? "\"\"\""
					x.gsub!("\"\"\"", "")
					language = translator.detect(x)
					translated = translator.translate(x,language, language_code,"text/html")
					code_translated.gsub!(x, translated)
				end
			end
		elsif extension == '.rb'
			code_original.split(/(#.*\n)/).each do |x|
				if x[0] == "#"
					language = translator.detect(x)
					translated = "#" + translator.translate(x,language, language_code,"text/html") + "\n"
					code_translated.gsub!(x, translated)
				end
			end
		elsif ((extension == '.r') || 
			   (extension == '.coffee') || 
			   (extension == '.pl'))
			code_original.split(/(#.*\n)/).each do |x|
				if x[0] == "#"
					language = translator.detect(x)
					translated = "#" + translator.translate(x,language, language_code,"text/html") + "\n"
					code_translated.gsub!(x, translated)
				end
			end
		elsif extension == '.hs'
			code_original.split(/(\-\-.*\n)/).each do |x|
				if x[0] == "\-\-"
					language = translator.detect(x)
					translated = "\-\-" + translator.translate(x,language, language_code,"text/html") + "\n"
					code_translated.gsub!(x, translated)
				end
			end
		elsif extension == '.m'
			code_original.split(/(\%.*\n)/).each do |x|
				if x[0] == "\%"
					language = translator.detect(x)
					translated = "\%" + translator.translate(x,language, language_code,"text/html") + "\n"
					code_translated.gsub!(x, translated)
				elsif x.include? "\.\.\."
					x.gsub!("\.\.\.", "")
					language = translator.detect(x)
					translated = translator.translate(x,language, language_code,"text/html")
					code_translated.gsub!(x, translated)
				end
			end
		elsif extension == '.php'
			code_original.split(/(#.*\n)/).each do |x|
				if x[0] == "#"
					language = translator.detect(x)
					translated = "#" + translator.translate(x,language, language_code,"text/html") + "\n"
					code_translated.gsub!(x, translated)
				elsif x.include? "\/\/"
					x.gsub!("\n", "")
					language = translator.detect(x)
					translated = translator.translate(x,language, language_code,"text/html")
					code_translated.gsub!(x, translated)
				end
			end
		elsif ((extension == '.c') || 
			   (extension == '.java') || 
			   (extension == '.js'))
			code_original.split(/(\/\/.*\n)/).each do |x|
				if x[0] == "\/\/"
					language = translator.detect(x)
					translated = "\/\/" + translator.translate(x,language, language_code,"text/html") + "\n"
					code_translated.gsub!(x, translated)
				end
			end
		else
			redirect_to static_pages_invalid_url_path
		end
		code_translated
	end
end