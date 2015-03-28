module StaticPagesHelper
	
	def run_translation(code_original)
		translator = MicrosoftTranslator::Client.new('GitATranslation', 'cwzLCkrF5eAIejqfZn8zx/QkDBESQMzo/OO/gzBRGtU=')
		code_translated = code_original
		code_original.split(/(#(.*)\n)|("""(.*)""")/).each do |x|
			if x[0] == "#"
				language = translator.detect(x)
				translated = translator.translate(x,language,"es","text/html") + "\n"
				code_translated.gsub!(x, translated)
			elsif x.include? "\"\"\""
				x.gsub!("\"\"\"", "")
				language = translator.detect(x)
				translated = translator.translate(x,language,"es","text/html")
				code_translated.gsub!(x, translated)
			end
		end
		code_translated
	end
end
