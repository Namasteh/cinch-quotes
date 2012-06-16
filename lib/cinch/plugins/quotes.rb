require 'cinch'
require 'yaml'

module Cinch
  module Plugins
    class Quotes
      include Cinch::Plugin

      QUOTES_FILE = "data/quotes.yml"

      match /addquote (.+)/i,  method: :addquote
      match /quote (.+)/i,     method: :quote
      match "quote",           method: :quote

      def addquote(m, quote)
        # make the quote
        new_quote = { "quote" => quote, "added_by" => m.user.nick, "created_at" => Time.now, "deleted" => false }

        # add it to the list
        existing_quotes = get_quotes || []
        existing_quotes << new_quote

        # find the id of the new quote and set it based on where it was placed in the quote list
        new_quote_index = existing_quotes.index(new_quote)
        existing_quotes[new_quote_index]["id"] = new_quote_index + 1

        # write it to the file
        output = File.new(QUOTES_FILE, 'w')
        output.puts YAML.dump(existing_quotes)
        output.close

        # send reply that quote was added
        m.reply "#{m.user.nick}: Quote successfully added as ##{new_quote_index + 1}."
      end

      def quote(m, search = nil)
        quotes = get_quotes.delete_if{ |q| q["deleted"] == true }
        if search.nil? # we are pulling random
          quote = quotes.sample
          m.reply "#{m.user.nick}: ##{quote["id"]} - #{quote["quote"]}"
        elsif search.to_i != 0 # then we are searching be id
          quote = quotes[(search.to_i - 1)]
          if quote.nil?
            m.reply "#{m.user.nick}: No quotes found."
          else 
            m.reply "#{m.user.nick}: ##{quote["id"]} - #{quote["quote"]}"
          end
        else 
          quotes.keep_if{ |q| q["quote"].downcase.include?(search.downcase) }
          if quotes.empty?
            m.reply "#{m.user.nick}: No quotes found."
          else
            quote = quotes.first
            m.reply "#{m.user.nick}: ##{quote["id"]} - #{quote["quote"]}"
            m.reply "The search term also matched on quote IDs: #{quotes.map{|q| q["id"]}.join(", ")}" if quotes.size > 1
          end
        end
      end

      #--------------------------------------------------------------------------------
      # Protected
      #--------------------------------------------------------------------------------
      
      protected

      def get_quotes
        output = File.new(QUOTES_FILE, 'r')
        quotes = YAML.load(output.read)
        output.close

        quotes
      end

    end
  end
end
