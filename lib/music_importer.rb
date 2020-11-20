
class MusicImporter
    
    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def files
        Dir.entries(@path).reject {|i| i == "." || i == ".."}
    end

    def import
        files.each do |file_name|
            Song.create_from_filename(file_name)
        end
    end
end