var app = angular.module('myApp', []);

app.controller('imgControl', function($scope, $http) {

	$http.get("/list")
	.success(function(data){
		$scope.images = data.vote;
	})


    $http.get("/list")
        .success(function(data) {
            $scope.images = data;
        });
    $http.get("/list")
        .success(function(data) {
            $scope.images = data;
        });

    $scope.toVote = '投ta一票';

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



{
    vote[
        {
            "id":"2",
            "path":"url",
            "voters":"num"
        },{
            "id":"2",
            "path":"url",
            "voters":"num"
        }
    ]
}