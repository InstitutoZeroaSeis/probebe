angular.module('gallery')
  .directive('uploader', [ '$timeout', ($timeout) ->
    restrict: 'E'
    replace: true
    templateUrl: '/assets/angular/gallery/directives/uploader/uploader.html',
    scope:{
      imageType: '@'
      cropRatio: '@'
    }
    controller: [ '$scope', '$sce', 'GalleryImageService', 'ImageDataService', ($scope, $sce, GalleryImageService, ImageDataService) ->

      $scope.uploading = false
      $scope.points = {}
      $scope.jCropApi = null

      $scope.getButtonLabel = ->
        return 'Upload' if !$scope.uploading
        return 'Uploading...'

      calculateRatio = (coords) ->
        image = $('#choosed-image')[0]

        cssHeight = parseInt(image.style.height)
        height = image.naturalHeight
        ratioH = height/cssHeight

        cssWidth = parseInt(image.style.width)
        width = image.naturalWidth
        ratioW = width/cssWidth

        coords.x = coords.x * ratioW
        coords.y = coords.y * ratioH
        coords.w = coords.w * ratioW
        coords.h = coords.h * ratioH
        coords

      updateCrop = (coords) ->
        if coords.w <= 0 || coords.h <= 0
          return
        coords = calculateRatio(coords)
        image = $('#choosed-image')[0]
        canvas = document.createElement('canvas')
        canvas.width = coords.w
        canvas.height = coords.h
        ctx = canvas.getContext('2d')
        ctx.drawImage(image, coords.x, coords.y, coords.w, coords.h, 0, 0, coords.w, coords.h)
        $scope.$apply ->
          $scope.preview = canvas.toDataURL()
          $scope.imageWidth = coords.w.toFixed 2
          $scope.imageHeight = coords.h.toFixed 2

      addCrop = ->
        if $scope.jCropApi
          $scope.jCropApi.destroy()
        props = {}
        props.onChange = updateCrop
        props.onSelect = updateCrop
        if $scope.cropRatio
          props.aspectRatio = $scope.cropRatio
        $scope.jCropApi = $.Jcrop '#choosed-image', props

      resizeImage = ->
        $('#choosed-image').each ->
          maxWidth = 600
          maxHeight = 400
          ratio = 0
          width = $(this).width()
          height = $(this).height()
          if width > maxWidth
            ratio = maxWidth / width
            $(this).css 'width', maxWidth
            $(this).css 'height', height * ratio
            height = height * ratio
            width = width * ratio
          if height > maxHeight
            ratio = maxHeight / height
            $(this).css 'height', maxHeight
            $(this).css 'width', width * ratio
            width = width * ratio
            height = height * ratio

      showImage = ->
        $scope.$apply ->
          if $scope.jCropApi
            $scope.jCropApi.destroy()
          $scope.picture = ''
          selector = ".probebe-gallery-#{$scope.imageType} #picture"
          pic = $(selector)[0].files[0]
          reader = new FileReader()

          reader.onload = (e) ->
            $scope.$apply () ->
              $scope.picture = $sce.trustAsHtml("<img id='choosed-image' src='#{e.target.result}'></img>")
              $timeout(->

                selector = "#gallery-image-modal_#{$scope.imageType}"
                $(selector).dialog(
                  close: () =>
                    $scope.$apply ->
                      if $scope.jCropApi
                        $scope.jCropApi.destroy()
                      $scope.picture = ''

                  minWidth: 800
                  minHeight: 500
                  maxHeight: 500
                )
              , 0)
              $timeout(resizeImage, 100)
              $timeout(addCrop, 200)


          reader.readAsDataURL(pic)

      $scope.onChange = () ->
        showImage()

      imageToUpload = () ->
        pic = null
        if $scope.preview
          selector = ".probebe-gallery-#{$scope.imageType} #picture"
          imageTag = $(selector)[0].files[0]
          pic = ImageDataService.dataURIToBlob $scope.preview, imageTag.name
        else
          selector = ".probebe-gallery-#{$scope.imageType} #picture"
          pic = $(selector)[0].files[0]
        pic

      $scope.upload = () ->
        $scope.uploading = true
        pic = imageToUpload()
        GalleryImageService.upload(pic, $scope.imageType)
          .then (image) ->
            $scope.uploading = false
            selector = "#gallery-image-modal_#{$scope.imageType}"
            $(selector).dialog('close')
            selector = ".probebe-gallery-#{$scope.imageType} #picture"
            $(selector).val ''
            $scope.jCropApi.destroy()
            $scope.picture = ''
            $scope.preview = ''
    ]
  ])
