module Capybara
  module Angular
    module DSL
      include Capybara::DSL

      Capybara::Session::DSL_METHODS.each do |method|
        define_method(method) do |*args, &block|
          page.send(method, *args, &block)
        end
      end

      def page
        wait_until_angular_ready
        Capybara.current_session
      end

      def wait_until_angular_ready
        Waiter.new(Capybara.current_session).wait_until_ready
      end
    end
  end
end

