var powerApp = angular.module('powerApp', []);

powerApp.controller('powerDisplay', function ($scope) {
  $scope.getStates = function(){
    $.ajax({
      url: "states/index",
      type: "GET",
      dataType: "json"
    })
    .done(function( data ) {
      $scope.states = data
      $scope.$apply()
    })
  }
  $scope.getStates()

  $scope.orderProp = 'total_power_score';
  $scope.direction = true;
  
  $scope.sort = function(column) {
    if ($scope.orderProp === column) {
      $scope.direction = !$scope.direction;
    } else {
      $scope.orderProp = column;
      $scope.direction = true;
    }
  }
})

