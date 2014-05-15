#!/usr/bin/ruby
require 'mechanize'

$agent = Mechanize.new
$pwd = Dir.pwd



def get_xkcd(number, caption = false, location = nil,name = nil)

	page = $agent.get("http://xkcd.com/#{number}/")
	comic = page.image_with(:src => /\/comics\//)
	last_dot = comic.src.rindex('.')
	extension = comic.src[last_dot..-1]
	if location.nil?
		location = $pwd
	end

	if name.nil? 
		name = "\##{number} - "+comic.alt
	end

	path_to_file = location+'/'+name
	comic.fetch.save path_to_file + extension
	if caption
		File.open(path_to_file + " - caption",'w') do |f|
			f.write comic.title
		end
	end
end
