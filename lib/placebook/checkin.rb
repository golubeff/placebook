class Placebook
  # A simple wrapper for the Checkin object.
  # It is a subclass of a hash, but has method accessors.
  class Checkin < Hashie::Mash
    def initialize(hash, *args)
      hash['place'] = Place.new(hash['place']) if hash['place']
      hash['from'] = User.new(hash['from']) if hash['from']
      super(hash, *args)
    end
  end

  class Place < Hashie::Mash
    def initialize(hash, *args)
      hash['location'] = Location.new(hash['location']) if hash['location']
      super(hash, *args)
    end
  end

  class Location < Hashie::Mash
  end

  class User < Hashie::Mash
  end
end
