

class MusicLibraryController
    
    attr_accessor :path

    def initialize(path='./db/mp3s')
        @path = path
        MusicImporter.new(path).import
    end

    def call
        input = ""
        while input
            puts ""
             puts "Welcome to your music library!"
             puts "To list all of your songs, enter 'list songs'."
             puts "To list all of the artists in your library, enter 'list artists'."
             puts "To list all of the genres in your library, enter 'list genres'."
             puts "To list all of the songs by a particular artist, enter 'list artist'."
             puts "To list all of the songs of a particular genre, enter 'list genre'."
             puts "To play a song, enter 'play song'."
             puts "To quit, type 'exit'."
             puts "What would you like to do?"
        
            input = gets.chomp
    
            case input
                when 'list songs'
                  self.list_songs
                  puts ""
                when 'list artists'
                  self.list_artists
                  puts ""
                when 'list genres'
                  self.list_genres
                  puts ""
                when 'list artist'
                  self.list_songs_by_artist
                  puts ""
                when 'list genre'
                  self.list_songs_by_genre
                  puts ""
                when 'play song'
                  self.play_song
                  puts ""
                when "exit"
                    break
                else
                  puts "Type in a valid request please"
                  puts ""
            end
        end
    end

    def list_songs
        counter = 1
        Song.all.sort_by {|song|song.name}.each do |song|
            puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            counter += 1
        end
    end

    def list_artists
        Artist.all.sort {|a,b| a.name <=> b.name}.each.with_index(1) {|artist, i| puts "#{i}. #{artist.name}"}
    end

    def list_genres
        Genre.all.sort {|a,b| a.name <=> b.name}.each.with_index(1) {|genre, i| puts "#{i}. #{genre.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        if artist = Artist.find_by_name(gets.chomp)
            artist.songs.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, i|
              puts "#{i}. #{song.name} - #{song.genre.name}" 
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"    
        if genre = Genre.find_by_name(gets.chomp)
          genre.songs.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, i|
            puts "#{i}. #{song.artist.name} - #{song.name}"
          end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        song_number_input = gets.chomp.to_i
        if (1..Song.all.length).include?(song_number_input)
          song = Song.all.sort{ |a, b| a.name <=> b.name }[song_number_input - 1] 
        end
        puts "Playing #{song.name} by #{song.artist.name}" if song
  end
end
