var app = angular.module('myApp', []);

app.controller('imgControl', function($scope, $http) {

	$http.get("/list")
	.success(function(data){
		$scope.images = data;
	})


    $http.get("/list")
        .success(function(data) {
            $scope.images = data;
        });
    /* $scope.images = [{
         "id": "1",
         "path": "https://ss1.bdstatic.com/kvoZeXSm1A5BphGlnYG/bigicon/24/101.png",
         "voters": "5"
     }, {
         "id": "2",
         "path": "https://ss1.bdstatic.com/kvoZeXSm1A5BphGlnYG/bigicon/24/101.png",
         "voters": "5"
     }, {
         "id": "3",
         "path": "https://ss1.bdstatic.com/kvoZeXSm1A5BphGlnYG/bigicon/24/101.png",
         "voters": "5"
     }]*/

    $scope.toVote = '投我一票';
    $scope.vote = function(obj) {
        console.log(obj.x.id)
        $http.get('/vote?id=' + obj.x.id)
            .success(function() {
                $scope.toVope = '已投';
                $http.get("/list")
                    .success(function(data) {
                        $scope.images = data;
                    });
            });
    };

});

