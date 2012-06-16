# Cinch-Quotes - Quotes plugin

## Description

This is a quotes plugin for Cinch bots. 

## Installation

### RubyGems

You can install the latest Cinch-Quotes gem using RubyGems

    gem install cinch-quotes

### GitHub

Alternatively you can check out the latest code directly from Github

    git clone http://github.com/caitlin/cinch-quotes.git

## Usage

Install the gem and load it in your Cinch bot:

    require "cinch"
    require "cinch/plugins/quotes"

    bot = Cinch::Bot.new do
      configure do |c|
        # add all required options here
        c.plugins.plugins = [Cinch::Plugins::Quotes] # optionally add more plugins
      end
    end

    bot.start


## Commands

### !quote

The bot will reply with a random quote. You can optionally provide an ID or a search term for the bot to return a specific quote.

### !addquote

Add a quote to the bot.

