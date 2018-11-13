# frozen_string_literal: true

require 'rubygems'
require 'mechanize'

module RutrackerApi
  class Client
    attr_accessor :agent

    LOGIN_PAGE = 'https://rutracker.org/forum/login.php'.freeze
    SEARCH_PAGE = 'https://rutracker.org/forum/tracker.php'.freeze

    ORDER_OPTIONS = { date: 1, name: 2, downloads: 4, shows: 6, seeders: 10,
                      leechers: 11, size: 7, last_post: 8, speed_up: 12,
                      speed_down: 13, message_count: 5, last_seed: 9 }.freeze
    SORT_OPTIONS = { asc: 1, desc: 2 }.freeze

    def initialize(username, pass)
      @agent = Mechanize.new
      @agent.user_agent_alias = 'Mac Safari'
      login(username, pass)
    end

    # Advance search throw rutracker
    #
    # @param options [Hash] the format type, `:category`, `:term`, `:sort`, `:order_by`
    # @return [Hash] the options keys with search result
    def search(options = {})
      query = prepare_query_string options
      @agent.get query
      parse_search
    end

    private

    def login(username, pass)
      @agent.post(LOGIN_PAGE, login_username: username,
                              login_password: pass, login: 'Вход')
    end

    def prepare_query_string(options)
      prepared = { f: options[:category], nm: options[:term],
                   s: SORT_OPTIONS[options[:sort]], o: ORDER_OPTIONS[options[:order_by]] }

      StringIO.new.tap do |q|
        q << "#{SEARCH_PAGE}?"
        q << "nm=#{prepared[:nm]}" if prepared[:nm]
        q << "&f=#{prepared[:f]}" if prepared[:f]
        q << "&o=#{prepared[:o]}" if prepared[:o]
        q << "&s=#{prepared[:s]}" if prepared[:s]
      end.string
    end

    def parse_search
      @agent.page.search("//table[@class='forumline tablesorter']/tbody/tr").map do |row|
        return { error: 'Not found' } if row.css('.row1').text =~ /Не найдено/

        description = row.at('td[4]').text.strip
        torrent_id = row.at('td[4]//a').attributes['data-topic_id'].text.to_i
        size = row.at('td[6]/a').text.chomp(' ↓')
        seeders = row.at('td[7]').text.to_i
        leechers = row.at('td[8]').text.to_i
        downloads = row.at('td[9]').text.to_i
        date = Time.strptime(row.at('td[10]/u').text, '%s')
        author = row.css('.u-name/a').text
        user_id = row.css('.u-name/a')[0]['href'].scan(/\d+/)[0].to_i

        { description: description, torrent_id: torrent_id, size: size,
          seeders: seeders, leechers: leechers, downloads: downloads,
          date: date, author: author, user_id: user_id }
      end
    end
  end
end
