module Capybara
  module Angular
    class Waiter
      WAITER_JS = IO.read(File.expand_path "../waiter.js", __FILE__)

      attr_accessor :page

      def initialize(page)
        @page = page
      end

      def wait_until_ready
        return unless driver_supports_js?
        start = Time.now

        until ready?
          inject_waiter
          timeout! if timeout?(start)
          sleep(0.01)
        end
      end

      private

      def driver_supports_js?
        page.evaluate_script "true"
      rescue Capybara::NotSupportedByDriverError
        false
      end

      def timeout?(start)
        Time.now - start > Capybara::Angular.default_max_wait_time
      end

      def timeout!
        raise Timeout::Error.new("timeout while waiting for angular")
      end

      def inject_waiter
        return if page.evaluate_script("window.capybaraAngularReady !== undefined")
        page.execute_script WAITER_JS
      end

      def ready?
        page.evaluate_script("window.capybaraAngularReady === true")
      end
    end
  end
end
