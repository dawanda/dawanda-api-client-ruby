module Dawanda
  module Model # :nodoc:all
    
    module ClassMethods
      
      def attribute(name, options = {})
        from = parse_from(name,options)
        if from.is_a? Array
          class_eval <<-CODE
            def #{name}
              @result['#{from.first}']['#{from.last}']
            end
          CODE
        else
          class_eval <<-CODE
            def #{name}
              @result['#{from}']
            end
          CODE
        end
      end
      
      def parse_from(name,options)
        from = options.fetch(:from,name)
        return from unless from.is_a? Hash
        key = from.keys.first
        value = from.fetch(key)
        [key,value]
      end
      
      def attributes(*names)
        names.each {|name| attribute(name) }
      end

      def finder(type, endpoint)
        parameter = endpoint.scan(/:\w+/).first
        parameter.sub!(/^:/, '')

        endpoint.sub!(":#{parameter}", '#{' + parameter + '}')

        send("find_#{type}", parameter, endpoint)
      end
      
      def find_all(parameter, endpoint)
        class_eval <<-CODE
          def self.find_all_by_#{parameter}(#{parameter}, params = {})
            response = Request.get("#{endpoint}", params)
            response.result.map {|listing| new(listing) }
          end
        CODE
      end
      
      def find_one(parameter, endpoint)
        class_eval <<-CODE
          def self.find_by_#{parameter}(#{parameter}, params = {})
            response = Request.get("#{endpoint}", params)
            new response.result
          end
        CODE
      end
      
    end
    
    module InstanceMethods
      
      def initialize(result = nil)
        @result = result
      end
      
    end
    
    def self.included(other)
      other.send(:extend, Dawanda::Model::ClassMethods)
      other.send(:include, Dawanda::Model::InstanceMethods)
    end
    
    
  end
end