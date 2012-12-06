Dir[File.dirname(__FILE__) + "/../lib/*.rb"].each do |source_file|
	require source_file
end
