angular.module "app", ["ngRoute", "routing_basics", "templates.app", "templates.common"]

angular.module("routing_basics", ['templates.app', 'templates.common']).config ($routeProvider) ->
  $routeProvider.when("/view1",
    templateUrl: "views/view1.tpl.html"
  ).when("/view2",
    templateUrl: "views/view2.tpl.html"
  ).otherwise redirectTo: "/view1"
