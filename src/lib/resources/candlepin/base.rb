module Resources::Candlepin
  class Base < ActiveResource::Base
    extend Resources::ActiveResource::WithoutJsonOrXmlFormatExtention
    include Resources::ActiveResource::WithOauth
    include Resources::ActiveResource::FixMissingContentLength

    self.prefix = URI.parse(AppConfig.candlepin.url).path
    self.site = self.prefix == "/" ? AppConfig.candlepin.url : AppConfig.candlepin.url.gsub(self.prefix, "")
    self.prefix = self.prefix + "/" unless self.prefix.end_with?("/")
    self.oauth_secret = AppConfig.candlepin.oauth_secret
    self.oauth_key = AppConfig.candlepin.oauth_key
    self.format = :json
    self.include_root_in_json = false
  end


end
