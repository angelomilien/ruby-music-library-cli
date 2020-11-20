require "pry"


class Song
    
    extend Concerns::Findable
    extend Concerns::Destroyable
    extend Concerns::Creatable
    attr_accessor :name, :artist, :genre
    
    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist=(artist) if artist
        self.genre=(genre) if genre
        save
    end

    # ********* Class Methods **************
    def self.all
        @@all
    end

    def self.new_from_filename(file_name)
        arg_1 = file_name.split(/ -|\./).reject {|i| i == "mp3"}[1].strip
        arg_2 = Artist.find_or_create_by_name(file_name.split(/ -|\./).reject {|i| i == "mp3"}[0].strip)
        arg_3 = Genre.find_or_create_by_name(file_name.split(/ -|\./).reject {|i| i == "mp3"}[2].strip)
        self.new(arg_1, arg_2, arg_3)
    end 

    def self.create_from_filename(file_name)
        new_from_filename(file_name)
    end


    # ********* Instances Methods ***********
    def save
        self.class.all << self
    end

    # ********* Instances Variables (attributes) ***********
    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self) 
    end
end

   


