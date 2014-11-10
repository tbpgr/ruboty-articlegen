# encoding: utf-8
require 'spec_helper'
require 'ruboty/gen'

# rubocop:disable LineLength, UnusedMethodArgument
describe Ruboty::Gen::Article do
  context :generate do
    let(:tmp) { 'tmp' }
    let(:ruboty_articlegen_template) do
      template = <<-EOS
# encoding: utf-8

user_name 'tbpgr'
gem_name 'sample_gem'
title 'チャットを空メッセージ or 任意のメッセージで埋める ruboty-sample_gem を作成しました'
purpose <<-PURPOSE
ruboty google_image で妙な画像を引き当ててしまった。
そんなときに限って、偉い人が近づいてくる。
急いでチャット画面から画像を追い出すんだ。

内緒のメッセージのやりとり。
そんなときに限って、内緒のやりとりがばれるとまずい相手が近づいてくる。
急いでチャット画面から画像を追い出すんだ。

そんな時に空行を大量に追加してメッセージを画面外に追い出します。
PURPOSE

env do |e|
  e.name 'ENV1'
  e.description 'ENV1 description'
end

env do |e|
  e.name 'ENV2'
  e.description 'ENV2 description'
end

dependency do |d|
  d.name 'dependency1 name'
  d.description 'dependency1 description'
end

dependency do |d|
  d.name 'dependency2 name'
  d.description 'dependency2 description'
end

command do |c|
  c.name 'command1'
  c.pattern '/command1 | hoge/'
  c.description 'command1 description'
  c.example <<-EXAMPLE
>ruboty command1
>result1
  EXAMPLE
end

command do |c|
  c.name 'command2'
  c.pattern '/command2 | hoge/'
  c.description 'command2 description'
  c.example <<-EXAMPLE
>ruboty command2
>result2
  EXAMPLE
end
      EOS
      template
    end

    cases = [
      {
        case_no: 1,
        case_title: 'valid case',
        expected: <<-EOS
# チャットを空メッセージ or 任意のメッセージで埋める ruboty-sample_gem を作成しました #ruboty

## 概要
チャットを空メッセージ or 任意のメッセージで埋める ruboty-sample_gem を作成しました

## 用途
ruboty google_image で妙な画像を引き当ててしまった。
そんなときに限って、偉い人が近づいてくる。
急いでチャット画面から画像を追い出すんだ。

内緒のメッセージのやりとり。
そんなときに限って、内緒のやりとりがばれるとまずい相手が近づいてくる。
急いでチャット画面から画像を追い出すんだ。

そんな時に空行を大量に追加してメッセージを画面外に追い出します。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-sample_gem'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruboty-sample_gem

## Commands

|Command|Pattern|Description|
|:--|:--|:--|
|command1|/command1 &#124; hoge/|command1 description|
|command2|/command2 &#124; hoge/|command2 description|

## Usage
### command1
* command1 description

~~~
>ruboty command1
>result1
~~~

### command2
* command2 description

~~~
>ruboty command2
>result2
~~~

## ENV

|Name|Description|
|:--|:--|
|ENV1|ENV1 description|
|ENV2|ENV2 description|

## Dependency

|Name|Description|
|:--|:--|
|dependency1 name|dependency1 description|
|dependency2 name|dependency2 description|

## 参照
* [ruboty-sample_gem GitHub](https://github.com/tbpgr/ruboty-sample_gem)
* [ruboty-sample_gem RubyGems](http://rubygems.org/gems/ruboty-sample_gem)
        EOS
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          # nothing

          # -- when --
          Ruboty::Gen::Article.generate
          actual = File.open('ruboty-sample_gem.md', 'r:utf-8') { |e|e.read }

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(_c)
        FileUtils.mkdir_p(tmp) unless Dir.exist? tmp
        Dir.chdir(tmp)
        File.open(Ruboty::Gen::Article::RUBOTY_MEGEN_FILE, 'w:utf-8') do |file|
          file.puts ruboty_articlegen_template
        end
      end

      def case_after(_c)
        Dir.chdir('../')
        FileUtils.rm_rf(tmp) if Dir.exist? tmp
      end
    end
  end
end
# rubocop:enable LineLength, UnusedMethodArgument
