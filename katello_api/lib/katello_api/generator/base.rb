#!/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'json'
require 'thor'
require 'thor/group'
require 'fileutils'
require 'active_support/inflector'
require 'active_support/core_ext/hash/indifferent_access'
require 'action_view'
require 'katello_api/base'
require 'net/http'
require 'uri'
require 'pp'

module KatelloApi
  module Generator

    class Base < Thor::Group
      include Thor::Actions
      include ActionView::Helpers::SanitizeHelper

      attr_reader :doc, :resource, :resource_key

      def initialize(doc, *args)
        super
        @doc = doc.first
      end

      def self.source_root
        File.expand_path("../template", __FILE__)
      end

      def self.start(katello_url)
        katello_url = katello_url.sub(/\.json\Z/,"")
        katello_url << "/#{KatelloApi::Base::API_VERSION}.json"
        uri = URI(katello_url)
        http = Net::HTTP.new(uri.host, uri.port)
        if uri.scheme == "https"
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        response = http.get(uri.path)

        unless response.code == "200"
          raise "Could not load data from #{katello_url}"
        end
        doc = JSON.load(response.body).with_indifferent_access
        destination = File.expand_path("../../../..", __FILE__)
        super([doc[:docs]], :destination_root => destination)
      end

      def generate
        doc[:resources].each do |key, resource|
          @resource_key, @resource = key, resource
          template("resource.rb.tt", "lib/katello_api/resources/#{resource_name}.rb")
        end
      end

      protected

      def camelizer(string)
        string = string.sub(/^[a-z\d]*/) { $&.capitalize }
        string.gsub(/(?:_|(\/))([a-z\d]*)/i) { "#{$2.capitalize}" }
      end

      # Resource related helper methods:

      def resource_name
        resource[:name].gsub(/\s/, "_").downcase.singularize
      end

      def api(method)
        method[:apis].first
      end

      def validation(method)
        stringify = lambda do |object|
          case object
            when Hash
              clone = object.dup
              object.keys.each { |key| clone[key.to_s] = stringify[clone.delete(key)] }
              clone
            when Array
              object.map { |value| stringify[value] }
            else
              object
          end
        end
        KatelloApi::Base.construct_validation_hash(stringify[method])
      end

      def format_param_description(descr, prefix = '')
        unless descr.empty?
          prefix + strip_tags(descr).gsub(/\n/,' ').capitalize
        end
      end

      def prioritize_id(param)
        return '' if param.upcase == 'ID'
        param
      end

    end
  end
end
