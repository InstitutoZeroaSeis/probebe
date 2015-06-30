angular.module('gallery')
  .directive('probebeGallery', [ '$templateCache', ($templateCache) ->
    restrict: 'E'
    replace: true
    scope: {
      pictureTagName: '@',
      imageUrl: '@'
      imageId: '@'
      type: '@'
    }
    templateUrl: '/assets/angular/gallery/directives/probebe_gallery/probebe_gallery.html',
    controller: [ '$scope', 'GalleryImageService', ($scope, GalleryImageService) ->
      $scope.showGallery = ->
        selector = "#gallery-images-container_#{$scope.type}"
        $(selector).dialog(
          minWidth: 600
          maxHeight: 500
        )
    ]
  ])
