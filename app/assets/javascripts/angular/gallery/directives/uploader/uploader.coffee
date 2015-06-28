angular.module('gallery')
  .directive('uploader', [ '$timeout', ($timeout) ->
    restrict: 'E'
    replace: true
    templateUrl: '/assets/angular/gallery/directives/uploader/uploader.html',
    controller: [ '$scope', 'GalleryImageService', 'ImageDataService', ($scope, GalleryImageService, ImageDataService) ->

      $scope.points = {}
      $scope.jCropApi = null

      calculateRatio = (coords) ->
        image = $('#choosed-image')[0]
        cssHeight = parseInt(image.style.height)
        height = image.naturalHeight
        ratio = height/cssHeight
        coords.x = coords.x * ratio
        coords.y = coords.y * ratio
        coords.w = coords.w * ratio
        coords.h = coords.h * ratio
        coords

      updateCrop = (coords) ->
        coords = calculateRatio(coords)
        image = $('#choosed-image')[0]
        canvas = document.createElement('canvas')
        canvas.width = coords.w
        canvas.height = coords.h
        ctx = canvas.getContext('2d')
        ctx.drawImage(image, coords.x, coords.y, coords.w, coords.h, 0, 0, coords.w, coords.h)
        $scope.$apply ->
          $scope.preview = canvas.toDataURL()

      addCrop = ->
        if $scope.jCropApi
          $scope.jCropApi.destroy()
        $scope.jCropApi = $.Jcrop '#choosed-image',
                      onChange: updateCrop
                      onSelect: updateCrop

      showImage = ->
        pic = document.getElementById('picture').files[0]
        reader = new FileReader()

        reader.onload = (e) ->
          $scope.$apply () ->
            $scope.picture = e.target.result
            $timeout(addCrop, 0)

        reader.readAsDataURL(pic)

      $scope.onChange = () ->
        showImage()

      $scope.upload = () ->
        imageTag = document.getElementById('picture').files[0]
        pic = ImageDataService.dataURIToBlob $scope.preview, imageTag.name
        GalleryImageService.upload(pic, $scope.points)
          .then (image) ->
            $('#picture').val ''
            $scope.jCropApi.destroy()
            $scope.picture = ''
            $scope.preview = ''
    ]
  ])
