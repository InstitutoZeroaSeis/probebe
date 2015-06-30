angular.module('gallery')
  .directive('probebeGallery', [ '$templateCache', ($templateCache) ->
    restrict: 'E'
    replace: true
    scope: {
      pictureTagName: '@',
      imageUrl: '@'
      imageId: '@'
    }
    templateUrl: '/assets/angular/gallery/directives/probebe_gallery/probebe_gallery.html',
    controller: [ '$scope', 'GalleryImageService', ($scope, GalleryImageService) ->
      $scope.showGallery = ->
        $('#gallery-images-container').dialog(
          minWidth: 600
          maxHeight: 500
        )
    ]
  ])
