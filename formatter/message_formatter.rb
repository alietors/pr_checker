class MessageFormatter
  def initialize(**image)
    @image_url = image['url']
  end

  def format_message(**pr)
    generate_image + generate_message(pr['pull_request'])
  end

  private def generate_message(**pr)
    "@#{pr['pull_request'].reviewer.name} you have a PR waiting from"\
    "@#{pr['pull_request'].creator.name}\n#{pr['pull_request'].url}"
  end

  private def generate_image
    (@image_url.nil? || @image_url.empty?) ? '' : "![Image](#{@image_url})\n"
  end
end
