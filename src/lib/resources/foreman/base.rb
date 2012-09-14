module Resources::Foreman
  class Base < ActiveResource::Base
    include Resources::ActiveResource::WithoutJsonOrXmlFormatExtention
    include Resources::ActiveResource::WithOauth


    self.prefix = URI.parse(AppConfig.foreman.url).path
    self.site = self.prefix == "/" ? AppConfig.foreman.url : AppConfig.foreman.url.gsub(self.prefix, "")
    self.prefix = self.prefix + "/" unless self.prefix.end_with?("/")
    self.oauth_secret = AppConfig.foreman.oauth_secret
    self.oauth_key = AppConfig.foreman.oauth_key
    self.format = :json
    self.include_root_in_json = true
  end
end