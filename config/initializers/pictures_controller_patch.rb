Ckeditor::PicturesController.class_eval do

  def create
    @picture = Ckeditor.picture_model.new
    custom_respond_with_asset(@picture)
  end

  private

  def custom_respond_with_asset(asset)
    file = params[:CKEditor].blank? ? params[:qqfile] : params[:upload]
    asset.data = Ckeditor::Http.normalize_param(file, request)

    callback = ckeditor_before_create_asset(asset)

    if callback && asset.save
      crop_image(asset)
      if params[:CKEditor].blank?
        render :json => asset.to_json(:only=>[:id, :type])
      else
        render :text => %Q"<script type='text/javascript'>
            window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, '#{config.relative_url_root}#{Ckeditor::Utils.escape_single_quotes(asset.url_content)}');
          </script>"
      end
    else
      if params[:CKEditor].blank?
        render :nothing => true, :format => :json
      else
        render :text => %Q"<script type='text/javascript'>
            window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, null, '#{Ckeditor::Utils.escape_single_quotes(asset.errors.full_messages.first)}');
          </script>"
      end
    end
  end

  def crop_image(asset)
    return if params[:crop_x].blank?
    asset.crop_x = params[:crop_x]
    asset.crop_y = params[:crop_y]
    asset.crop_w = params[:crop_w]
    asset.crop_h = params[:crop_h]
    asset.data.reprocess!
  end

end
