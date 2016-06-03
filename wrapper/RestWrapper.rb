require 'unirest'

class RestWrapper

  def initialize(token)
    @header = { "content-type" => "application/json", "Authorization" => "token #{token}" }
  end
  def get(url)
    return Unirest.get(url, headers:@header)
  end

  def post(url, message)
    return Unirest.post(
                        url,
                        headers:@header,
                        parameters:{"body" => message}.to_json
                        )
  end
end