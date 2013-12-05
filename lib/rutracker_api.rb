# -*- coding: utf-8 -*-
require 'rubygems'
require 'mechanize'
require 'dotenv'

class RutrackerApi

  Dotenv.load
  attr_accessor :agent

  LOGIN_PAGE = 'http://login.rutracker.org/forum/login.php'
  SEARCH_PAGE = 'http://rutracker.org/forum/tracker.php'

  ORDER_OPTIONS = { date: 1,  name: 2, downloads: 4, shows: 6, seeders: 10,
                    leechers: 11, size: 7, last_post: 8, speed_up: 12,
                    speed_down: 13, message_count: 5, last_seed: 9 }
  SORT_OPTIONS = {asc: 1, desc: 2}

  def initialize
    @agent = Mechanize.new
    @agent.user_agent_alias = 'Mac Safari'
    login
  end

  # Advance search throw rutracker
  #
  # @param option [Hash] the format type, `:category`, `:term`, `:sort`, `:order_by`
  # @return [Hash] the options keys with search result
  def search(options = {})
    query = prepare_query_string options
    @agent.get query
    parse_search
  end

  def find_user(nick)
    # TODO: add parser for user pages
    @agent.get 'http://rutracker.org/forum/profile.php?mode=viewprofile&u=' + nick
  end

  private
    def login
      @agent.post(LOGIN_PAGE, login_username: ENV["RUTRACKER_LOGIN"],
                  login_password: ENV["RUTRACKER_PASS"], login: 'Вход')
    end

    def prepare_query_string(options)
      prepared = { f: options[:category], nm: options[:term],
        s: SORT_OPTIONS[options[:sort]], o: ORDER_OPTIONS[options[:order_by]] }

      query = SEARCH_PAGE + '?'
      if prepared[:nm]
        query.gsub! '&', ''
        query << "nm=%22#{prepared[:nm]}%22"
      end
      query << "&f=#{prepared[:f]}" if prepared[:f]
      query << "&f=#{prepared[:o]}" if prepared[:order_by]
      query << "&f=#{prepared[:s]}" if prepared[:sort]
      query
    end

    def parse_search
    @agent.page.search("//table[@class='forumline tablesorter']/tbody/tr").map do |row|
      if row.css(".row1").text =~ /Не найдено/
        return {error: 'Not found'}
      end
      description = row.at("td[4]").text.strip
      torrent_id =  row.at("td[4]//a").attributes['data-topic_id'].text.to_i
      size = row.at("td[6]/a").text.chomp(" ↓")
      seeders = row.at("td[7]").text.to_i
      leechers = row.at("td[8]").text.to_i
      downloads = row.at("td[9]").text.to_i
      date = DateTime.strptime(row.at("td[10]/u").text, '%s')
      author = row.css(".u-name/a").text
      user_id = row.css(".u-name/a")[0]['href'].scan(/\d+/)[0].to_i

      { description: description, torrent_id: torrent_id, size: size,
        seeders: seeders, leechers: leechers, downloads: downloads,
        date: date, author: author, user_id: user_id }
    end
  end
end
