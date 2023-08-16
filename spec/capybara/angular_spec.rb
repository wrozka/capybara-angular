require 'simplecov'
SimpleCov.minimum_coverage 82.7
SimpleCov.start 'rails'

require 'rack'
require 'puma'
require 'rack/handler/puma'
require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara/angular'

Capybara.default_driver = :poltergeist
Capybara.app = Rack::Directory.new('spec/public')
Capybara.default_max_wait_time = 2
Capybara::Angular.default_max_wait_time = 10

describe 'Waiting for angular' do
  include Capybara::Angular::DSL

  it 'when manually bootstrapping an angular application' do
    open_manual_bootstrap_page
    timeout_page_should_have_waited
  end

  it 'when using ng-app to bootstrap an application' do
    open_ng_app_bootstrap_page
    timeout_page_should_have_waited
  end

  it 'when using ng-app not on the body tag to bootstrap an application' do
    open_ng_app_not_on_body_bootstrap_page
    timeout_page_should_have_waited
  end

  it 'when visiting a non-angular page' do
    open_non_angular_page
    non_angular_page_should_load
  end

  it 'when visiting a non-angular page that loads angular javascript' do
    open_non_angular_page_with_angular_javascript
    non_angular_page_should_load
  end

  def open_manual_bootstrap_page
    visit '/manual.html'
  end

  def open_ng_app_bootstrap_page
    visit '/ng-app.html'
  end

  def open_ng_app_not_on_body_bootstrap_page
    visit '/ng-app-not-on-body.html'
  end

  def open_non_angular_page
    visit '/non-angular-page.html'
  end

  def open_non_angular_page_with_angular_javascript
    visit '/non-angular-page-with-angular-javascript.html'
  end

  def timeout_page_should_have_waited
    expect(page).to have_content('waited')
  end

  def non_angular_page_should_load
    expect(page).to have_content('non-angular page')
  end
end
