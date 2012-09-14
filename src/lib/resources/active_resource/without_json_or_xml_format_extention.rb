module Resources::ActiveResource::WithoutJsonOrXmlFormatExtention
  def element_path(options = nil)
    super(options).gsub(/.json|.xml/, '')
  end

  def new_element_path
    super.gsub(/.json|.xml/, '')
  end

  def collection_path(options = nil)
    super(options).gsub(/.json|.xml/, '')
  end
end