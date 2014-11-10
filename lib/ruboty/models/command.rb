# encoding: utf-8

module Ruboty
  module Models
    # Command
    class Command
      def initialize
        @name, @pattern, @description, @example = ''
      end

      def name(name)
        @name = name
      end

      def pattern(pattern)
        @pattern = pattern
      end

      def description(description)
        @description = description
      end

      def example(example)
        @example = example
      end

      [:name, :pattern, :description, :example].each do |m|
        define_method :"read_#{m}" do
          instance_variable_get("@#{m}")
        end
      end
    end
  end
end
