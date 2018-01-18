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
          if page_reloaded_on_wait?
            return unless angular_app?
            setup_ready
          end
          sleep(0.01)
        end
      end

      private

      def timeout?(start)
        Time.now - start > Capybara::Angular.default_max_wait_time
      end

      def timeout!
        raise Timeout::Error.new("timeout while waiting for angular")
      end

      def ready?
        page.evaluate_script("window.angularReady")
      end

      def angular_app?
        js = '!!window.angular'
        page.evaluate_script js

      rescue Capybara::NotSupportedByDriverError
        false
      end

      def setup_ready
        page.execute_script <<-JS
          var el = document.querySelector('[ng-app], [data-ng-app]') || document.body;
          var injector = angular.element(el).injector();

          window.angularReady = false;

          function capybaraAngularSetupReady() {
            try {
              angular.getTestability(el).whenStable(function() { window.angularReady = true; });
            } catch(error) {
              var $browser = injector.get('$browser');
              if ($browser.outstandingRequestCount > 0) { window.angularReady = false; }
              $browser.notifyWhenNoOutstandingRequests(function() { window.angularReady = true; });
            } 
          }

          if (injector === void 0) {
            var tid = setInterval(function() {
              injector = angular.element(el).injector();
              if (injector === void 0) return;
              clearInterval(tid);
              capybaraAngularSetupReady();
            }, 100);
          } else capybaraAngularSetupReady();
        JS
      end

      def page_reloaded_on_wait?
        page.evaluate_script("window.angularReady === undefined")
      end
    end
  end
end
