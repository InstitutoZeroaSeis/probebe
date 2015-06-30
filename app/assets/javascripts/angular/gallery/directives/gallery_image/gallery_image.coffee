angular.module('gallery')
  .directive('galleryImage', [ '$templateCache', ($templateCache) ->
    restrict: 'E'
    replace: true
    scope: {
      image: '='
      imageType: '@'
    }
    templateUrl: '/assets/angular/gallery/directives/gallery_image/gallery_image.html',
    controller: [ '$scope', 'GalleryImageService', ($scope, GalleryImageService) ->
      $scope.select = () ->
        GalleryImageService.setSelectedImage $scope.image, $scope.imageType
        selector = "#gallery-images-container_#{$scope.imageType}"
        $(selector).dialog('close')
    ]
  ])
