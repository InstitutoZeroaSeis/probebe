angular.module('gallery')
  .service( 'GalleryImageService', [ '$http', '$q',  ($http, $q) ->
    @images = []

    @syncList = () ->
      deferred = $q.defer()
      $http(
        method: 'GET'
        url: '/admin/gallery_images.json'
      ).success( (data) =>
        @images = data.gallery_images
        deferred.resolve data
      ).error( (data) =>
        @images = []
        deferred.reject data
      )

      deferred.promise

    getCookie = (name) ->
      c = null
      value = '; ' + document.cookie
      parts = value.split('; ' + name + '=')
      if parts.length == 2
        c = parts.pop().split(';').shift()
      c

    @upload = (image) ->
      deferred = $q.defer()
      authenticity_token = getCookie 'XSRF-TOKEN'
      xhr = new XMLHttpRequest
      xhr.open 'POST', "/ckeditor/pictures?authenticity_token=#{authenticity_token}&qqfile=" + image.name, true

      xhr.onload = =>
        if xhr.status == 200
          resp = JSON.parse(xhr.response)
          @images.push resp
          deferred.resolve(resp)
        else
          deferred.reject("Error")
      xhr.send image

      deferred.promise


    @getList = () ->
      @images

    @
  ])
