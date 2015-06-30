angular.module('gallery')
  .directive('selectedImage', [ '$templateCache', ($templateCache) ->
    restrict: 'E'
    replace: true
    scope: {
      pictureTagName: '@',
      imageUrl: '@'
      pictureId: '@'
    }
    templateUrl: '/assets/angular/gallery/directives/selected_image/selected_image.html',
    controller: [ '$scope', 'GalleryImageService', ($scope, GalleryImageService) ->
      $scope.$on('selectedImageChange', (event, data) ->
        $scope.image = GalleryImageService.selectedImage
        $scope.imageUrl = $scope.image.url_content
        $scope.pictureId = $scope.image.id
      )

    ]
  ])
