module Resources::ActiveResource::FixMissingContentLength
  def load_attributes_from_response(response)
    if !response['Content-Length'].blank? && response['Content-Length'] != "0" && !response.body.nil? && response.body.strip.size > 0
      load(self.class.format.decode(response.body), true)
    end
  end
end
