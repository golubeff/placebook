module Placebook
  class Client
    attr_reader :app_id, :app_secret, :access_token
    
    # Provide your Facebook Application ID, Application Secret,
    # and an access token for some Facebook user to initialize
    # the client.
    def initialize(app_id, app_secret, access_token)
      @app_id = app_id
      @app_secret = app_secret
      @access_token = access_token
    end
    
    # Retrieves a single checkin based on the checkin_id.
    def checkin(id)
      checkinize(token.get("/#{id}"))
    end
    
    # Retrieves a group of checkins for a specific user,
    # page, user id, or page id.
    def checkins_for(entity)
      checkinize(token.get("/#{entity}/checkins"))
    end
    
    # Search for checkins with the given query.
    def search(query)
      checkinize(token.get("/search", :q => query, :type => 'checkin'))
    end
    
    def token#:nodoc:
      OAuth2::AccessToken.new(client, access_token)
    end
    
    def client#:nodoc:
      @client ||= OAuth2::Client.new(app_id, app_secret)
    end
    
    protected
    
    def checkinize(string)#:nodoc:
      case obj = MultiJson.decode(string)
        when Hash
          Checkin.new(obj)
        when Array
          obj.map{|h| Checkin.new(h)}
      end
    end
  end
end
