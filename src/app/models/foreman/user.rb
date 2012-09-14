class Foreman::User < Resources::Foreman::Base

  schema do
    string 'login', 'mail', 'password', 'admin', 'auth_source_id'
  end

  def to_json(options = {})
    super(options.merge(:only => [:login, :password, :mail, :auth_source_id]))
  end
end