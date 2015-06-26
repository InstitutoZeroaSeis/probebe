angular.module('gallery')
  .directive('uploader', [ '$templateCache', ($templateCache) ->
    {
      restrict: 'E'
      replace: true
      templateUrl: '/assets/angular/gallery/directives/uploader/uploader.html',
      controller: [ '$scope', 'GalleryImageService', ($scope, GalleryImageService) ->

        $scope.onChange = () ->
          pic = document.getElementById('picture').files[0]
          reader = new FileReader()

          reader.onload = (e) ->
            $scope.$apply () ->
              $scope.picture = e.target.result

          reader.readAsDataURL(pic)


        $scope.upload = () ->
          pic = document.getElementById('picture').files[0]
          GalleryImageService.upload(pic)
            .then (image) ->
              $('#picture').val ''

      ]
    }
  ])
