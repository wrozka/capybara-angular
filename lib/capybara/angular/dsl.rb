module Capybara
  module Angular
    module DSL
      include Capybara::DSL

      Capybara::Session::DSL_METHODS.each do |method|
        define_method(method) do |*args, **opts, &block|
          page.send(method, *args, **opts, &block)
        end
      end

      def page
        wait_until_angular_ready unless @ignoring_angular
        Capybara.current_session
      end

      def wait_until_angular_ready
        Waiter.new(Capybara.current_session).wait_until_ready
      end

      def ignoring_angular
        @ignoring_angular = true
        yield
      ensure
        @ignoring_angular = false
      end
    end
  end
end

