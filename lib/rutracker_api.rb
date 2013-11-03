require 'rubygems'
require 'mechanize'
class RutrackerApi

  attr_accessor :term, :result

  def initialize
    @agent = Mechanize.new
    @agent.get 'http://login.rutracker.org/forum/login.php'
    form = @agent.page.form('login-form')
    form.login_username = ENV["RUTRACKER_LOGIN"]
    form.login_password = ENV["RUTRACKER_PASSWORD"]
    @agent.submit(form, form.buttons.first)
  end
end
