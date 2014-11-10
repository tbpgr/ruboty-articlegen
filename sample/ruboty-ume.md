# チャットを空メッセージ or 任意のメッセージで埋める ruboty-ume を作成しました #ruboty

## 概要
チャットを空メッセージ or 任意のメッセージで埋める ruboty-ume を作成しました

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
gem 'ruboty-ume'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruboty-ume

## Commands

|Command|Pattern|Description|
|:--|:--|:--|
|ume|/ume (?<count>.*?)z/|output empty message N lines (<count> times)|
|umec|/umec (?<text>.+?) (?<count>.*?)z/|output <text> message N lines (<count> times)|

## Usage
### ume
* output empty message N lines (<count> times)

~~~
>ruboty command1
>result1
~~~

### umec
* output <text> message N lines (<count> times)

~~~
>ruboty command2
>result2
~~~

## ENV

|Name|Description|
|:--|:--|
|ENV1|ENV1 desc|
|ENV2|ENV2 desc|

## Dependency

|Name|Description|
|:--|:--|
|dependency1|dependency1 description|
|dependency2|dependency2 description|

## 参照
* [ruboty-ume GitHub](https://github.com/tbpgr/ruboty-ume)
* [ruboty-ume RubyGems](http://rubygems.org/gems/ruboty-ume)
