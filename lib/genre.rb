


class Genre
    
    extend Concerns::Findable
    extend Concerns::Destroyable
    extend Concerns::Creatable
    attr_accessor :name, :songs
    
    @@all = []

    def initialize(name, songs=[])
       @name = name
       @songs = songs
       save
    end
    
    # ********* Class Methods **************
    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def add_song(song)
        song.genre = self if song.genre != self
        @songs << song if @songs.include?(song) == false
    end

    def artists
        songs.collect { |song| song.artist}.uniq
    end
end