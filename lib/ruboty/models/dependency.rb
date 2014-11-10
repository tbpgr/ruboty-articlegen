# encoding: utf-8

module Ruboty
  module Models
    # Dependency
    class Dependency
      def initialize
        @name, @description = ''
      end

      def name(name)
        @name = name
      end

      def description(description)
        @description = description
      end

      [:name, :description].each do |m|
        define_method :"read_#{m}" do
          instance_variable_get("@#{m}")
        end
      end
    end
  end
end
