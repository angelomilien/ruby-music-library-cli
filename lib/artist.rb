


class Artist
    
    extend Concerns::Findable
    extend Concerns::Destroyable
    extend Concerns::Creatable
    attr_accessor :name, :songs
    
    @@all = []

    def initialize(name, songs=[])
        @name = name
        @songs =songs
        save
    end

    # ********* Class Methods **************
    def self.all
        @@all
    end

    # ********* Instances Methods ***********
    def save
        self.class.all << self
    end

    def add_song(song)
        song.artist = self if song.artist != self
        @songs << song if @songs.include?(song) == false
    end

    def genres
        songs.collect { |song| song.genre}.uniq 
    end
end