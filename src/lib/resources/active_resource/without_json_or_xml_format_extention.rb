module Resources::ActiveResource::WithoutJsonOrXmlFormatExtention
  def element_path(*args)
    super(*args).gsub(/.json|.xml/, '')
  end

  def new_element_path(*args)
    super(*args).gsub(/.json|.xml/, '')
  end

  def collection_path(*args)
    super(*args).gsub(/.json|.xml/, '')
  end
end
