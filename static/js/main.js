var app = angular.module('myApp', []);

app.controller('imgControl', function($scope, $http) {
	$http.get("/list")
	.success(function(data){
		$scope.images = data;
	})
})
