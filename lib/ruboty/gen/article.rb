# encoding: utf-8
require 'erb'

# rubocop:disable LineLength
module Ruboty
  module Gen
    # Article
    class Article
      RUBOTY_MEGEN_FILE = 'Rubotyariticle'
      RUBOTY_MEGEN_TEMPLATE = <<-EOS
# encoding: utf-8

# user_name(github user name)
# user_name is required
# user_name allow only String
# user_name's default value => "user_name"
user_name "user_name"

# gem_name
# gem_name is required
# gem_name allow only String
# gem_name's default value => "your_gem_name"
# ex: sample_gem (not ruboty-sample_gem)
gem_name "your_gem_name"

# title
# title is required
# title allow only String
# title's default value => "title"
# ex: チャットを空メッセージ or 任意のメッセージで埋める ruboty-ume を作成しました
title "title"

# purpose
# purpose is required
# purpose allow only String
# purpose's default value => "purpose"
# ex: ruboty google_image で妙な画像を引き当ててしまった。
# ex: そんなときに限って、偉い人が近づいてくる。
# ex: 急いでチャット画面から画像を追い出すんだ。
# ex:
# ex: 内緒のメッセージのやりとり。
# ex: そんなときに限って、内緒のやりとりがばれるとまずい相手が近づいてくる。
# ex: 急いでチャット画面から画像を追い出すんだ。
# ex:
# ex: そんな時に空行を大量に追加してメッセージを画面外に追い出します。
purpose <<-PURPOSE
plugin の用途を詳細に記述
PURPOSE

# you can set multiple ENV variables
env do |e|
  # name
  # name allow only String
  # name's default value => ""
  e.name "environment variable name"

  # description
  # description allow only String
  # description's default value => ""
  e.description ""
end

# you can set multiple dependencies
dependency do |d|
  # name
  # name allow only String
  # name's default value => ""
  d.name ""

  # description
  # description allow only String
  # description's default value => ""
  d.description ""
end

# you can set multiple commands
command do |c|
  # name
  # name allow only String
  c.name ""

  # pattern
  # pattern allow only String
  c.pattern ""

  # description
  # description allow only String
  c.description ""

  # example
  # example allow only String
  c.example ""
end
      EOS

      RUBOTY_ARTICLE_TEMPLATE = <<-EOS
# <%=title%> #ruboty

## 概要
<%=title%>

## 用途
<%=purpose%>
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-<%=gem_name%>'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruboty-<%=gem_name%>

## Commands

|Command|Pattern|Description|
|:--|:--|:--|
<%=command_table%>

## Usage
<%=usages%>

## ENV

|Name|Description|
|:--|:--|
<%=env_table%>

## Dependency

|Name|Description|
|:--|:--|
<%=dependency_table%>

## 参照
* [ruboty-<%=gem_name%> GitHub](https://github.com/<%=user_name%>/ruboty-<%=gem_name%>)
* [ruboty-<%=gem_name%> RubyGems](http://rubygems.org/gems/ruboty-<%=gem_name%>)
      EOS

      # generate Rubotyarticlegenfile to current directory.
      def self.init
        File.open(RUBOTY_MEGEN_FILE, 'w') do |f|
          f.puts RUBOTY_MEGEN_TEMPLATE
        end
      end

      # generate ruboty Article Markdown template.
      def self.generate
        src = read_dsl
        dsl = Ruboty::Dsl.new
        dsl.instance_eval src
        src = apply(dsl.ruboty_articlegen)
        File.open("ruboty-#{dsl.ruboty_articlegen.gem_name}.md", 'w:utf-8') do |file|
          file.puts src
        end
      end

      def self.read_dsl
        File.open(RUBOTY_MEGEN_FILE) { |f|f.read }
      end
      private_class_method :read_dsl

      # rubocop:disable UselessAssignment
      def self.apply(config)
        gem_name = config.gem_name
        title = config.title
        command_table = command_table(config.commands)
        usages = usages(config.commands)
        env_table = env_table(config.env)
        dependency_table = dependency_table(config.dependencies)
        user_name = config.user_name
        purpose = config.purpose

        erb = ERB.new(RUBOTY_ARTICLE_TEMPLATE)
        erb.result(binding)
      end
      private_class_method :apply
      # rubocop:enable UselessAssignment

      def self.command_table(commands)
        command_table = commands.each_with_object([]) do |e, memo|
          list = ['', e.read_name, e.read_pattern, e.read_description, '']
          list = normalize_markdown_table(list)
          memo << list.join('|')
        end
        command_table.join("\n")
      end
      private_class_method :command_table

      def self.usages(commands)
        usages = commands.each_with_object([]) do |e, memo|
          name = e.read_name
          description = e.read_description
          example = e.read_example.chomp
          row = ["### #{name}", "* #{description}", '', '~~~', "#{example}", '~~~']
          memo << row.join("\n")
        end
        usages.join("\n\n")
      end
      private_class_method :usages

      def self.env_table(env)
        env_table = env.each_with_object([]) do |e, memo|
          list = ['', e.read_name, e.read_description, '']
          list = normalize_markdown_table(list)
          memo << list.join('|')
        end
        env_table.join("\n")
      end
      private_class_method :env_table

      def self.dependency_table(dependencies)
        dependency_table = dependencies.each_with_object([]) do |e, memo|
          list = ['', e.read_name, e.read_description, '']
          list = normalize_markdown_table(list)
          memo << list.join('|')
        end
        dependency_table.join("\n")
      end
      private_class_method :dependency_table

      def self.normalize_markdown_table(texts)
        texts.map { |e| e.gsub('|', '&#124;') }
      end
      private_class_method :normalize_markdown_table
    end
  end
end
# rubocop:enable LineLength
