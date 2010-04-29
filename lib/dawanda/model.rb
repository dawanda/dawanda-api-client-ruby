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

      def finder(type, endpoint, name=nil)
        if name.nil?
          parameter = endpoint.scan(/:\w+/).first
          parameter.sub!(/^:/, '')
          
          endpoint.sub!(":#{parameter}", '#{' + parameter + '}')
          
          send("find_#{type}", parameter, endpoint)
        elsif type == :generic
          send("find_#{type}", name, endpoint)
        end
      end
      
      def find_all(parameter, endpoint)
        class_eval <<-CODE
          def self.find_all_by_#{parameter}(#{parameter}, params = {})
            response = Request.get("#{endpoint}", params.reject{|key, value| key == :raw_response})
            results = response.results.map {|listing| new(listing) }
            return OpenStruct.new({ :results => results, :entries => response.entries, :pages => response.pages, :type => response.type}) if params[:raw_response]
            results
          end
        CODE
      end
      
      def find_one(parameter, endpoint)
        class_eval <<-CODE
          def self.find_by_#{parameter}(#{parameter}, params = {})
            response = Request.get("#{endpoint}", params.reject{|key, value| key == :raw_response})
            return response if params[:raw_response]
            new response.result
          end
        CODE
      end
      
      def find_generic(name, endpoint)
        class_eval <<-CODE
          def self.find_#{name}(params = {})
            response = Request.get("#{endpoint}", params.reject{|key, value| key == :raw_response})
            return response if params[:raw_response]
            if response.result.nil?
              return OpenStruct.new({ :results => response.results.map {|listing| new(listing) }, :entries => response.entries, :pages => response.pages, :type => response.type}) if params[:raw_response]
              response.results.map {|listing| new(listing) }
            else
              return OpenStruct.new({ :result => new(response.result), :entries => response.entries, :pages => response.pages, :type => type}) if params[:raw_response]
              new response.result
            end
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
