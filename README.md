# Ruboty::Gen::Article

Generate Markdown Article for Ruboty Handler + Actions plugin.

[![Gem Version](https://badge.fury.io/rb/ruboty-articlegen.svg)](http://badge.fury.io/rb/ruboty-articlegen)
[![Build Status](https://travis-ci.org/tbpgr/ruboty-articlegen.png?branch=master)](https://travis-ci.org/tbpgr/ruboty-articlegen)
[![Coverage Status](https://coveralls.io/repos/tbpgr/ruboty-articlegen/badge.png)](https://coveralls.io/r/tbpgr/ruboty-articlegen)

[Ruboty](https://github.com/r7kamura/ruboty) is Chat bot framework. Ruby + Bot = Ruboty

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-articlegen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruboty-articlegen

## Rubotyme
### Setting File Parameters

|key|value|example|
|:--|:--|:--|
|github_user_name|github user name|tbpgr|
|rubygems_user_name|rubygems user name|tbpgr|
|gem_name|gem name|ume|
|title|タイトル文字列|チャットを空メッセージ or 任意のメッセージで埋める ruboty-ume を作成しました|
|purpose|用途|ruboty google_image で妙な画像を引き当ててしまった。<br>そんなときに限って、偉い人が近づいてくる。<br>急いでチャット画面から画像を追い出すんだ。<br><br>内緒のメッセージのやりとり。<br>そんなときに限って、内緒のやりとりがばれるとまずい相手が近づいてくる。<br>急いでチャット画面から画像を追い出すんだ。<br>そんな時に空行を大量に追加してメッセージを画面外に追い出します。|
|env/name|環境変数|DEFAULT_UME_TEXT|
|env/description|環境変数の説明|default ume text|
|dependencies/name|依存先名称|Ume API|
|dependencies/description|依存先説明|Ume API の説明やURL|
|commands/command name|Ruboty::Handler.on の name に設定する内容 ※件数分|ume|
|commands/command pattern|Ruboty::Handler.on の pattern に設定する内容 ※件数分|/ume (?<count>.*?)\z/  |
|commands/command description|Ruboty::Handler.on  の description に設定する内容 ※件数分|output empty message N lines (<count> times)|

## Usage
### init
generate Rubotyarticle template file.

~~~
$ ruboty-articlegen init
~~~

### generate
generate Ruboty Handler + Action Article Markdown template

* edit Rubotyme file

~~~ruby
# encoding: utf-8
github_user_name "tbpgr"
rubygems_user_name "tbpgr"

gem_name "ume"

title "チャットを空メッセージ or 任意のメッセージで埋める ruboty-ume を作成しました"

env do |e|
  e.name "ENV1"
  e.description "ENV1 desc"
end

env do |e|
  e.name "ENV2"
  e.description "ENV2 desc"
end

dependency do |d|
  d.name "dependency1"
  d.description "dependency1 description"
end

dependency do |d|
  d.name "dependency2"
  d.description "dependency2 description"
end

command do |c|
  c.name "ume"
  c.pattern "/ume (?<count>.*?)\z/"
  c.description "output empty message N lines (<count> times)"
end

command do |c|
  c.name "umec"
  c.pattern "/umec (?<text>.+?) (?<count>.*?)\z/"
  c.description "output <text> message N lines (<count> times)"
end
~~~

* generate Airticle Markdown

~~~
$ ruboty-articlegen generate
~~~

* output  
[sample output ruboty-ume ruboty-ume_article](https://github.com/tbpgr/ruboty-articlegen/blob/master/sample/ruboty-ume.md)

## Contributing

1. Fork it ( https://github.com/tbpgr/ruboty_articlegen/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
