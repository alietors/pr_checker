class MessageFormatter
  def initialize(url:)
    @image_url = url
  end

  def format_message(pull_request:)
    generate_image + generate_message(pull_request: pull_request)
  end

  private def generate_message(pull_request:)
    "@#{pull_request.reviewer.name} you have a PR waiting from "\
    "@#{pull_request.creator.name}\n#{pull_request.url}"
  end

  private def generate_image
    (@image_url.nil? || @image_url.empty?) ? '' : "![Image](#{@image_url})\n"
  end
end
