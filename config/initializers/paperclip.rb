Paperclip.interpolates('image_partition') do |attachment, style|
  attachment.instance.image_partition
end

Paperclip.interpolates('url_root') do |attachment, style|
  if Paperclip::Attachment.default_options[:storage] == :s3
    return ''
  else
    return '/system/'
  end
end

Paperclip.interpolates('path_root') do |attachment, style|
  if Paperclip::Attachment.default_options[:storage] == :s3
    return ''
  else
    return 'public/system/'
  end
end
