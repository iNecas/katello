class Candlepin::Consumer < Resources::Candlepin::Base

  set_primary_key :uuid

  def to_json(options = {})
    super(options.merge(:only => [:name]))
  end


end
