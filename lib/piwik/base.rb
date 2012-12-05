require 'rubygems'
require 'cgi'
require 'active_support/all'
require 'json/ext'
require 'rest_client'

module Piwik
  class ApiError < StandardError; end
  class MissingConfiguration < ArgumentError; end
  class UnknownSite < ArgumentError; end
  class UnknownUser < ArgumentError; end

  mattr_accessor :piwik_url
  mattr_accessor :auth_token

  def self.is_configured?
    @@piwik_url!=nil && @@auth_token!=nil
  end

  class Base
    @@template  = <<-EOF
# .piwik
# 
# Please fill in fields like this:
#
#  piwik_url: http://your.piwik.site
#  auth_token: secret
#
piwik_url: 
auth_token: 
EOF

  def self.config_file
    if defined?(Rails.root) && Rails.root!=nil
#     puts "config_file from Rails.root: #{Rails.root.to_s}"
      Rails.root.join('config', 'piwik.yml')
#   elsif defined?(RAILS_ROOT) && RAILS_ROOT!=nil
#     puts "config_file from RAILS_ROOT: #{RAILS_ROOT}"
#     File.join(RAILS_ROOT, 'config', 'piwik.yml')
    else
#     puts "config_file from ~/.piwik"
      File.join( ENV['HOME'] || ENV['USERPROFILE'] || ENV['HOMEPATH'] || ".", '.piwik' )
    end
  end

  def self.parse_json json
    JSON.parse json
  end
  
  def parse_json json 
    self.class.parse_json json
  end
  
  private
    # Calls the supplied Piwik API method, with the supplied parameters.
    # 
    # Returns a string containing the XML reply from Piwik, or raises a 
    # <tt>Piwik::ApiError</tt> exception with the error message returned by Piwik 
    # in case it receives an error.
    def call(method, params={})
      self.class.call(method, params, config[:piwik_url], config[:auth_token])
    end
    
    # Calls the supplied Piwik API method, with the supplied parameters.
    # 
    # Returns the object parsed from JSON reply from Piwik, or raises a 
    # <tt>Piwik::ApiError</tt> exception with the error message returned by Piwik 
    # in case it receives an error.
    def self.call(method, params={}, piwik_url=nil, auth_token=nil)
      raise MissingConfiguration, "Please edit #{config_file} to include your piwik url and auth_token or configure Piwik.piwik_url and Piwik.auth_token before use" if piwik_url.nil? || auth_token.nil?
      url = "#{piwik_url}/?module=API&format=json&method=#{method}"
      url << "&token_auth=#{auth_token}" unless auth_token.nil?
      params.each { |k, v| url << "&#{k}=#{CGI.escape(v.to_s)}" }
      verbose_obj_save = $VERBOSE
      $VERBOSE = nil # Suppress "warning: peer certificate won't be verified in this SSL session"
      json = nil
      resource=RestClient::Resource.new url,:timeout => 20, :open_timeout => 5
      json = resource.get
      
      $VERBOSE = verbose_obj_save
      result = self.parse_json json
      if json =~ /error message=/
        raise ApiError, result['error']['message'] if result['error']
      end
      result
    end
    
    # Checks for the config, creates it if not found
    def self.load_config
      config = {}
      if Piwik.is_configured?
        config = { :piwik_url => Piwik.piwik_url, :auth_token => Piwik.auth_token }
      else
        config_file = self.config_file
        if config_file
          temp_config = if File.exists?(config_file)
            YAML::load(open(config_file))
          else
            open(config_file,'w') { |f| f.puts @@template }
            YAML::load(@@template)
          end
          temp_config.each { |k,v| config[k.to_sym] = v } if temp_config
        end
        raise MissingConfiguration, "Please edit #{config_file} to include piwik url and auth_token or configure Piwik.piwik_url and Piwik.auth_token before use" if config[:piwik_url] == nil || config[:auth_token] == nil
        #cache settings
        Piwik.piwik_url = config[:piwik_url]
        Piwik.auth_token = config[:auth_token]
      end
      config
    end
  end
end
