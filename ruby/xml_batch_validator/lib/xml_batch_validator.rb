#XmlBatchValidator
#
# Description:
# validates xml files
# returns not valid files

class XmlBatchValidator
  def initialize(files)
		require 'rubygems'
		require 'xml'
		@files = Dir.glob(files)
  end
	def validate
		out = []
		@files.each do |f|
			begin
				d = LibXML::XML::Document.file(f)
			rescue
				out << f
			ensure
				d = nil
			end
			GC.start
		end
		out	
	end
end