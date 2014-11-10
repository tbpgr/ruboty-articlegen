# encoding: utf-8
require 'ruboty/dsl/dsl_model'
require 'ruboty/models/env'
require 'ruboty/models/dependency'
require 'ruboty/models/command'

module Ruboty
  # Dsl
  class Dsl
    attr_accessor :ruboty_articlegen

    [:user_name, :gem_name, :title, :purpose].each do |f|
      define_method f do |value|
        @ruboty_articlegen.send("#{f}=", value)
      end
    end

    def env
      e = Ruboty::Models::Env.new
      yield(e)
      @ruboty_articlegen.env << e
    end

    def dependency
      d = Ruboty::Models::Dependency.new
      yield(d)
      @ruboty_articlegen.dependencies << d
    end

    def command
      c = Ruboty::Models::Command.new
      yield(c)
      @ruboty_articlegen.commands << c
    end

    def initialize
      @ruboty_articlegen = Ruboty::DslModel.new
      @ruboty_articlegen.user_name = 'your user_name username'
      @ruboty_articlegen.gem_name = 'your_gem_name'
      @ruboty_articlegen.title = 'title'
      @ruboty_articlegen.purpose = 'purpose'
      @ruboty_articlegen.env = []
      @ruboty_articlegen.dependencies = []
      @ruboty_articlegen.commands = []
    end
  end
end
