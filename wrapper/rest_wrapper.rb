require 'unirest'

class RestWrapper
  CONTENT_KEY = 'content-type'.freeze
  AUTH_KEY =  'Authorization'.freeze
  BODY_KEY = 'body'.freeze

  def initialize(token)
    @header = { CONTENT_KEY => 'application/json', AUTH_KEY => "token
#{token}" }
  end

  def get(url)
    Unirest.get(url, headers: @header)
  end

  def post(url, message)
    Unirest.post(url, headers: @header, parameters: { BODY_KEY => message }
                                                       .to_json)
  end
end
