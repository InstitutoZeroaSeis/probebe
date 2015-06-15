Carnival.configure do |config|
  Rails.application.config.assets.precompile += %w( carnival/* )
  config.menu = {
    administration: {
      label: 'administration',
      link: '/admin/customers',
      class: 'administracao',
      subs: [
        {
          label: 'admin_site_users',
          link: '/admin/admin_site_users'
        },
        {
          label: 'site_users',
          link: '/admin/site_users'
        },
        {
          label: 'categories',
          link: '/admin/categories'
        },
        {
          label: 'messages',
          link: '/admin/messages'
        },
        {
          label: 'articles',
          link: '/admin/articles'
        },
        {
          label: 'tags',
          link: '/admin/tags'
        },
        {
          label: 'message_deliveries',
          link: '/admin/message_deliveries'
        },
        {
          label: 'authors',
          link: '/admin/authors'
        }
      ]
    }
  }

  config.custom_javascript_files = %w(
    ckeditor/init
    inputs/countable_input
    jquery-ui/datepicker-pt-BR
    article_tags.js
    jquery.tagit.js
  )
  config.custom_css_files = %w(jquery-ui admin jquery.tagit.css)
  config.use_full_model_name = false
  config.root_action = 'admin/articles#index'
end
