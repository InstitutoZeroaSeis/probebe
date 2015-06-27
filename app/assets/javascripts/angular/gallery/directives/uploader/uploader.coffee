angular.module('gallery')
  .directive('uploader', [ '$timeout', ($timeout) ->
    {
      restrict: 'E'
      replace: true
      templateUrl: '/assets/angular/gallery/directives/uploader/uploader.html',
      controller: [ '$scope', 'GalleryImageService', ($scope, GalleryImageService) ->

        $scope.points = {}

        updateCrop = (coords) ->
          image = $('#image-preview img')[0]
          canvas = document.createElement('canvas')
          canvas.width = coords.w
          canvas.height = coords.h
          ctx = canvas.getContext('2d')
          ctx.drawImage(image, coords.x, coords.y, coords.w, coords.h, 0, 0, coords.w, coords.h)
          $scope.$apply ->
            $scope.preview = canvas.toDataURL()

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

        dataURItoBlob = (dataURI) ->
          # convert base64/URLEncoded data component to raw binary data held in a string
          byteString = undefined
          if dataURI.split(',')[0].indexOf('base64') >= 0
            byteString = atob(dataURI.split(',')[1])
          else
            byteString = unescape(dataURI.split(',')[1])
          # separate out the mime component
          mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0]
          # write the bytes of the string to a typed array
          ia = new Uint8Array(byteString.length)
          i = 0
          while i < byteString.length
            ia[i] = byteString.charCodeAt(i)
            i++
          pic = document.getElementById('picture').files[0]
          image = new Blob([ ia ], type: mimeString)
          image.name = pic.name
          image

        $scope.upload = () ->
          pic = dataURItoBlob $scope.preview
          GalleryImageService.upload(pic, $scope.points)
            .then (image) ->
              $('#picture').val ''
      ]
    }
  ])
