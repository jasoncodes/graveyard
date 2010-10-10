module WorkflowMax

  class Base
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming
    include ActiveModel::Serialization
    include HTTParty

    headers 'User-Agent' => 'Graveyard (+http://graveyardapp.com/)'
    base_uri "api.workflowmax.com/"
    format :xml
    headers 'Accept' => 'application/xml'

    class_attribute :api_key
    class_attribute :account_key

    self.api_key = ENV['WORKFLOWMAX_API_KEY']
    self.account_key = ENV['WORKFLOWMAX_ACCOUNT_KEY']

    def self.class_name
      name.gsub(/.+::/,'')
    end

    def self.api_name
      "#{class_name.underscore}.api"
    end

    def self.all
      list
    end

    def self.list(options = {})
      path = options.delete(:path) || "/#{api_name}/list"
      response = get(path, options)['Response']
      raise "Bad status: #{response.inspect}" unless response && response['Status'] == 'OK'
      lists = response.slice(class_name.pluralize, "#{class_name}List")
      if lists.size != 1
        raise "Could not find list in response"
      end
      list = lists.values.first.try(:[], class_name) || []
      list = [list] unless list.is_a? Array
      list.map do |row|
        new row
      end
    end

    def self.fix_attributes(data)
      HashWithIndifferentAccess.new Hash[
        data.map do |key,value|
          value = case value
          when Hash
            fix_attributes value
          when Array
            value.map do |entry|
              entry.is_a?(Hash) ? fix_attributes(entry) : entry
            end
          else
            value
          end
          [key.to_s.underscore.to_sym, value]
        end
      ]
    end

    def self.find(id)
      response = get("/#{api_name}/get/#{id}")['Response']
      raise "Bad status: #{response.inspect}" unless response && response['Status'] == 'OK'
      new response[class_name]
    end

    attr_accessor :attributes

    def initialize(attributes)
      self.attributes = self.class.fix_attributes(attributes)
    end

    def inspect
      "#<#{self.class} #{attributes.map { |k,v| k.to_s + ': ' + v.inspect }.join ', '}>"
    end

    def method_missing(method, *args)
      attribute_name = method.to_s.sub(/[?!=]$/, '')
      if attributes.key?(attribute_name.to_sym) && !self.class.method_defined?(attribute_name)
        self.class.send :define_method, "#{attribute_name}" do
          self.attributes[attribute_name.to_sym]
        end
        self.class.send :define_method, "#{attribute_name}=" do |value|
          self.attributes[attribute_name.to_sym] = value
        end
        send method, *args
      else
        super
      end
    end

    class << self

      def perform_request_with_account_key(http_method, path, options)
        options = options ? options.dup : {}
        raise "No API key" if api_key.blank?
        raise "No account key" if account_key.blank?
        options = { :query => { :apiKey => api_key, :accountKey => account_key } }.deep_merge(options)
        perform_request_without_account_key http_method, path, options
      end

      alias_method_chain :perform_request, :account_key

    end

  end

  module AwesomePrint

    def self.included(base)
      unless base.method_defined? :printable_without_workflow_max
        base.send :alias_method_chain, :printable, :workflow_max
      end
    end

    def printable_with_workflow_max(object)
      printable = printable_without_workflow_max(object)
      if printable == :self && object.is_a?(::WorkflowMax::Base)
        printable = :workflow_max_instance
      else
        printable
      end
    end

    def awesome_workflow_max_instance(object)
      "#{object} #{awesome_hash(object.attributes)}"
    end

  end

end

AwesomePrint.send(:include, WorkflowMax::AwesomePrint) if defined? AwesomePrint
