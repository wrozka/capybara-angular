angular.module('app', ['ng']).controller('waitingController', function($scope, $timeout) {
  $timeout(function() {
    $scope.text = 'waited';
  }, 5000);
});
