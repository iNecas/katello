# This is an almost-verbatim copy of aeolus-image-rubygem/lib/aeolus_image/active_resource_with_oauth.rb

class Resources::ActiveResource::OauthConnection < ActiveResource::Connection
  attr_accessor :oauth_key, :oauth_secret

  def request(method, path, *arguments)
    result = ActiveSupport::Notifications.instrument("request.active_resource") do |payload|
      payload[:method] = method
      payload[:request_uri] = "#{site.scheme}://#{site.host}:#{site.port}#{path}"
      oauth_consumer = OAuth::Consumer.new(
          oauth_key,
          oauth_secret,
          :site => site )
      token = OAuth::AccessToken.new(oauth_consumer)
      base_request = oauth_consumer.create_signed_request(method, path, token, {}, *arguments)
      payload[:result] = http.request(base_request)
    end
    # Error-handling code from OAuth
    # http://wiki.oauth.net/w/page/12238543/ProblemReporting
    auth_header = result.to_hash['www-authenticate']
    problem_header = auth_header ? auth_header.select{|h| h =~ /^OAuth /}.select{|h| h =~ /oauth_problem/}.first : nil
    if auth_header && problem_header
      params = OAuth::Helper.parse_header(problem_header)
      raise OAuth::Problem.new(params.delete("oauth_problem"), result, params)
    end
    # Error-handling code from active_resource
    handle_response(result)
  rescue Timeout::Error => e
    raise TimeoutError.new(e.message)
  rescue OpenSSL::SSL::SSLError => e
    raise SSLError.new(e.message)
  end
end