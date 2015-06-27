angular.module('gallery')
  .directive('uploader', [ '$timeout', ($timeout) ->
    {
      restrict: 'E'
      replace: true
      templateUrl: '/assets/angular/gallery/directives/uploader/uploader.html',
      controller: [ '$scope', 'GalleryImageService', ($scope, GalleryImageService) ->

        $scope.points = {}

        updateCrop = (coords) ->
          $scope.points.crop_x = coords.x
          $scope.points.crop_y = coords.y
          $scope.points.crop_w = coords.w
          $scope.points.crop_h = coords.h

        addCrop = ->
          $('#image-preview img').Jcrop(
            onChange: updateCrop
            onSelect: updateCrop
          )

        addPreview = ->
          pic = document.getElementById('picture').files[0]
          reader = new FileReader()

          reader.onload = (e) ->
            $scope.$apply () ->
              $scope.picture = e.target.result
              $timeout(addCrop, 0)

          reader.readAsDataURL(pic)

        $scope.onChange = () ->
          addPreview()

        $scope.upload = () ->
          pic = document.getElementById('picture').files[0]
          GalleryImageService.upload(pic, $scope.points)
            .then (image) ->
              $('#picture').val ''
      ]
    }
  ])
