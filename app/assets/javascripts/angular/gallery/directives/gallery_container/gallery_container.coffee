angular.module('gallery')
  .directive('galleryContainer', [ '$templateCache', ($templateCache) ->
    {
      restrict: 'E'
      replace: true
      scope: {
        picturesUrl: '@'
        imageType: '@'
      }
      templateUrl: '/assets/angular/gallery/directives/gallery_container/gallery_container.html',
      controller: [ '$scope', 'GalleryImageService', ($scope, GalleryImageService) ->

        $scope.openGallery = ->
          $("#gallery-images-container_#{$scope.imageType}").dialog(
            minWidth: 800
            maxHeight: 100
          )

        init = ->
          GalleryImageService.syncList()
            .then ->
              $scope.images = GalleryImageService.getList()


        init()
      ]
    }
  ])
