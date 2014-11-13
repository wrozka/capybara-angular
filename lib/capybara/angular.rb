require "capybara"
require "capybara/dsl"

require_relative "angular/dsl"
require_relative "angular/waiter"

module Capybara
  module Angular
    def self.default_wait_time
      @default_wait_time || Capybara.default_wait_time
    end

    def self.default_wait_time=(timeout)
      @default_wait_time = timeout
    end
  end
end
