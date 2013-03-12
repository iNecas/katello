require 'json'
require 'yaml'

module KatelloApi
  def self.client_config
    @client_config ||= YAML.load_file("#{root}/katello_api/config.yml")
  end

  def self.root
    @root ||= File.expand_path(File.dirname(__FILE__))
  end

  def self.doc
    @doc ||= File.open("#{root}/katello_api/documentation.json", 'r') do |f|
      JSON.load(f.read)['docs']
    end
  end
end

require 'katello_api/base'
require 'katello_api/version'
resource_files = Dir[File.expand_path("#{KatelloApi.root}/katello_api/resources/*.rb", __FILE__)]
resource_files.each { |f| require f }
