angular.module('gallery')
  .directive('galleryContainer', [ '$templateCache', ($templateCache) ->
    {
      restrict: 'E'
      replace: true
      scope: {
        picturesUrl: '@'
      }
      templateUrl: '/assets/angular/gallery/directives/gallery_container/gallery_container.html',
      controller: [ '$scope', 'GalleryImageService', ($scope, GalleryImageService) ->

        init = ->
          GalleryImageService.syncList()
            .then ->
              $scope.images = GalleryImageService.getList()


        init()
      ]
    }
  ])
