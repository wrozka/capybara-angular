module Capybara
  module Angular
    class Waiter
      attr_accessor :page

      def initialize(page)
        @page = page
      end

      def wait_until_ready
        return unless angular_app?

        setup_ready

        start = Time.now
        until ready?
          timeout! if timeout?(start)
          sleep(0.01)
        end
      end

      private

      def timeout?(start)
        Time.now - start > Capybara.default_wait_time
      end

      def timeout!
        raise TimeoutError.new("timeout while waiting for angular")
      end

      def ready?
        page.evaluate_script("window.angularReady")
      end

      def angular_app?
        begin
          js = "(typeof angular !== 'undefined') && "
          js += "angular.element(document.querySelector('[ng-app]')).length > 0"
          page.evaluate_script js
        rescue Capybara::NotSupportedByDriverError
          false
        end
      end

      def setup_ready
        page.execute_script <<-JS
          window.angularReady = false;
          var app = angular.element(document.querySelector('[ng-app]'));
          var injector = app.injector();

          injector.invoke(function($browser) {
            $browser.notifyWhenNoOutstandingRequests(function() {
              window.angularReady = true;
            });
          });
        JS
      end
    end
  end
end
