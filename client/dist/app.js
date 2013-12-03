(function() {
  angular.module("app", ["ngRoute", "routing_basics", "templates.app", "templates.common"]);

  angular.module("routing_basics", ['templates.app', 'templates.common']).config(function($routeProvider) {
    return $routeProvider.when("/view1", {
      templateUrl: "views/view1.tpl.html"
    }).when("/view2", {
      templateUrl: "views/view2.tpl.html"
    }).otherwise({
      redirectTo: "/view1"
    });
  });

}).call(this);

angular.module('templates.app', ['views/view1.tpl.html', 'views/view2.tpl.html']);

angular.module("views/view1.tpl.html", []).run(["$templateCache", function($templateCache) {
  $templateCache.put("views/view1.tpl.html",
    "<h2>View 1</h2><a href=\"#/view2\">Click to see View 2</a>");
}]);

angular.module("views/view2.tpl.html", []).run(["$templateCache", function($templateCache) {
  $templateCache.put("views/view2.tpl.html",
    "<h2>View 2</h2><a href=\"#/view1\">Click to see View 1</a>");
}]);

angular.module('templates.common', []);

