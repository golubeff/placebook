class Placebook
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
    def search(query, args={})
      checkinize(token.get("/search", { :q => query, :type => 'place' }.merge(args)))
    end
  
    def token#:nodoc:
      OAuth2::AccessToken.new(client, access_token)
    end
  
    def client#:nodoc:
      @client ||= OAuth2::Client.new(app_id, app_secret, :site => 'https://graph.facebook.com')
    end
  
    protected
  
    def checkinize(string)#:nodoc:
      obj = MultiJson.decode(string)
      obj = obj['data'] if obj.is_a?(::Hash) && obj.key?('data')
      case obj
        when Hash
          Checkin.new(obj)
        when Array
          obj.map{|h| Checkin.new(h)}
      end
    end
  end
end
