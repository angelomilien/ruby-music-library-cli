require 'bundler'
Bundler.require

module Concerns
    module Findable

        # ***** Class methods *******
        def find_by_name(name)
            self.all.detect {|i| i.name == name}
        end 
    
        def find_or_create_by_name(name)
            find_by_name(name) || create(name)
        end   
    end

    module Destroyable
        def destroy_all
            self.all.clear
        end
    end

    module Creatable
        def create(name)
            self.new(name)
        end
    end
end

require_all 'lib'
