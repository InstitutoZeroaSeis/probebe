angular.module('gallery')
  .directive('galleryImage', [ '$templateCache', ($templateCache) ->
    {
      restrict: 'E'
      replace: true
      scope: {
        image: '@'
      }
      templateUrl: '/assets/angular/gallery/directives/gallery_image/gallery_image.html'
    }
  ])
