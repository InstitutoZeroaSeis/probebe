# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_class = 'alert alert-danger col-sm-offset-2 col-sm-10'
  config.button_class = 'btn btn-default'
  config.boolean_label_class = nil

  config.wrappers :bootstrap, tag: 'div', class: 'form-group form-group-sm', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'col-sm-2 control-label'
    b.wrapper tag: 'div', class: 'col-sm-10' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
    end
  end


  config.wrappers :custom_forms, error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'form-label'
    b.wrapper tag: 'div', class: 'form-input' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
    end
  end


  config.wrappers :horizontal_file_input, tag: 'div', class: 'form-group form-group-sm', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :readonly
    b.use :label, class: 'col-sm-2 control-label'
    b.wrapper tag: 'div', class: 'col-sm-10' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.default_wrapper = :bootstrap
end
