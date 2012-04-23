Restapi.configure do |config|
  config.app_name = "Katello"
  config.app_info = "The sysadmin's fortress."
  config.copyright = "Copyright © 2012 Red Hat, Inc."
  config.api_base_url = "/api"
  config.doc_base_url = "/apidoc"
  config.validate = true
end

class NumberValidator < Restapi::Validator::BaseValidator

  def validate(value)
    value.to_s =~ /^(0|[1-9]\d*)$/
  end

  def self.build(param_description, argument, options, block)
    if argument == :number
      self.new(param_description) 
    end
  end

  def error
    "Parameter #{param_name} expecting to be a number, got: #{@error_value}"
  end

  def description
    "Parameter has to be a number."
  end
end

class IdentifierValidator < Restapi::Validator::BaseValidator

  def validate(value)
    value = value.to_s
    value =~ /\A[\w| |_|-]*\Z/ && value.strip == value && (2..128).include?(value.length)
  end

  def self.build(param_description, argument, options, block)
    if argument == :identifier
      self.new(param_description) 
    end
  end

  def error
    "Parameter #{param_name} expecting to be an identifier, got: #{@error_value}"
  end

  def description
    "Parameter has to be an identifier: string from 2 to 128 characters containting only alphanumeric characters, space, '_', '-' with no leading or trailing space.."
  end
end

class BooleanValidator < Restapi::Validator::BaseValidator

  def validate(value)
    [true, false].include?(value)
  end

  def self.build(param_description, argument, options, block)
    if argument == :bool
      self.new(param_description) 
    end
  end

  def error
    "Parameter #{param_name} expecting to be a boolean value, got: #{@error_value}"
  end

  def description
    "Parameter has to be a boolean"
  end
end
