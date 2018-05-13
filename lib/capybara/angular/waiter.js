// This script is injected from waiter.rb.  It is responsible for setting
// window.capybaraAngularReady when either a) angular is ready, or b)
// it determines the page is not an angular page.

(function () {
  "use strict";

  window.capybaraAngularReady = false;

  function ready() {
    window.capybaraAngularReady = true;
  }

  function angularPresent() {
    return window.angular !== undefined;
  }

  function element() {
    return document.querySelector("[ng-app], [data-ng-app]") || document.querySelector("body");
  }

  function elementPresent() {
    return element() !== undefined;
  }

  function setupTestability() {
    try {
      angular.getTestability(element()).whenStable(ready);
    } catch (err) {
      ready();
    }
  }

  function setupInjector() {
    try {
      angular.element(element()).injector().get("$browser").notifyWhenNoOutstandingRequests(ready);
    } catch (err) {
      ready();
    }
  }

  function setup() {
    if (!angularPresent() || !elementPresent()) {
      ready();
    } else if (angular.getTestability) {
      setupTestability();
    } else {
      setupInjector();
    }
  }

  setup();
}());
