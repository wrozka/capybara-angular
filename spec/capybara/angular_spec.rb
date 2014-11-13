require 'rack'
require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara/angular'

Capybara.default_driver = :poltergeist
Capybara.app = Rack::Directory.new('spec/public')
Capybara.default_wait_time = 2
Capybara::Angular.default_wait_time = 10

feature 'Waiting for angular' do
  include Capybara::Angular::DSL

  scenario 'without jquery' do
    open_timeout_page

    timeout_page_should_have_waited
  end

  def open_timeout_page
    visit '/index.html'
  end

  def timeout_page_should_have_waited
    expect(page).to have_content('waited')
  end
end
