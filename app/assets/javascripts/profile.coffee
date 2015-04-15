angular.module('profile', ['ngResource'])
.service('childService', ($resource) ->
  $resource('/children/:id', id: '@id')
)
.controller('ChildCtrl', ($scope, childService) ->
  $scope.editing_new_child = false
  $scope.children = childService.query()
  $scope.child = {}

  $scope.addNewChild = (born) ->
    $scope.editing_new_child = true
    $scope.child.born = born

  $scope.saveChild = (child) ->
    $scope.editing_new_child = false
    child.birth_date = weeks_ago_to_date(child.pregnancy_age_in_weeks)

    $scope.children.push(child)
    childService.save(child)
    $scope.child = {}

  weeks_ago_to_date = (weeks_ago) ->
    moment().subtract(weeks_ago, 'weeks').format('DD/MM/YYYY')
)
