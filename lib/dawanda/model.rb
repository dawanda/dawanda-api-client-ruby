module Dawanda
  module Model # :nodoc:all
    
    module ClassMethods
      
      def attribute(name, options=nil)
        options = name if options.nil?
        if options.is_a? Array
          class_eval <<-CODE
            def #{name}
              @result#{to_result_string(options)}
            end
          CODE
        else
          class_eval <<-CODE
            def #{name}
              @result['#{options}']
            end
          CODE
        end
      end
            
      def to_result_string options
        options.map! do |o| 
          if o.is_a? Numeric
            "[#{o}]"
          else
            "['#{o}']"
          end
        end
        options.join
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