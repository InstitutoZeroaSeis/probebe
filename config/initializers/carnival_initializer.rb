Carnival.configure do |config|
  Rails.application.config.assets.precompile += %w( carnival/* )
  config.menu = {
    administration: {
      label: 'administration',
      link: '/admin/customers',
      class: 'administracao',
      subs: [
        {
          label: 'Novo Artigo',
          link: '/admin/articles/new'
        },
        {
          label: 'Novo Post',
          link: '/admin/posts/new'
        },
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
          label: 'posts',
          link: '/admin/posts'
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
    },
    cms: {
      label: 'cms',
      link: '/admin/site_banners',
      class: 'administracao',
      subs: [
        {
          label: 'Site Banners',
          link: '/admin/site_banners'
        },
        {
          label: 'Site Headers',
          link: '/admin/site_headers'
        },
        {
          label: 'Landing Page',
          link: '/admin/site_landing_pages'
        },
        {
          label: 'Site Mobile',
          link: '/admin/site_mobile_images'
        },
        {
          label: 'Parceiros',
          link: '/admin/partners'
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
    jquery.minicolors.js
    jquery.modal.js
    jquery.minicolors.simple_form.js
    social-share-button.js
    angular.js
    jquery.Jcrop.min.js
  )
  config.custom_css_files = %w(
    jquery-ui
    admin
    jquery.tagit.css
    jquery.minicolors.css
    jquery.modal.css
    social-share-button.css
    angular.css
    jquery.Jcrop.min.css
  )
  config.use_full_model_name = false
  config.root_action = 'admin/articles#index'
end
