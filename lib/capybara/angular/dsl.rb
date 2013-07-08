module Capybara
  module Angular
    module DSL
      include Capybara::DSL

      Capybara::Session::DSL_METHODS.each do |method|
        define_method(method) do |*args, &block|
          wait_until_angular_ready
          Capybara.current_session.send(method, *args, &block)
        end
      end

      def wait_until_angular_ready
        Waiter.new(Capybara.current_session).wait_until_ready
      end

      extend DSL
    end
  end
end

