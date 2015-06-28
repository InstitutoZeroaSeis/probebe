angular.module('gallery')
  .service( 'ImageDataService', [ () ->
    @dataURIToBlob = (dataURI, name) ->
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
      image = new Blob([ ia ], type: mimeString)
      image.name = name
      image

    @
  ])
