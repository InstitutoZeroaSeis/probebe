Carnival.configure do |config|

  Rails.application.config.assets.precompile += %w( carnival/* )
  config.menu = {
    administration: {
      label: "administration",
      link: "/admin/customers",
      class: 'administracao',
      subs: [
        {
          label: "admin_site_users",
          link: "/admin/admin_site_users"
        },
        {
          label: "site_users",
          link: "/admin/site_users"
        },
        {
          label: "categories",
          link: "/admin/categories"
        },
        {
          label: "messages",
          link: "/admin/messages"
        },
        {
          label: "authorial_articles",
          link: "/admin/authorial_articles"
        },
        {
          label: "journalistic_articles",
          link: "/admin/journalistic_articles"
        },
        {
          label: "tags",
          link: "/admin/tags"
        },
        {
          label: "message_deliveries",
          link: "/admin/message_deliveries"
        }
      ]
    },
  }

  config.custom_javascript_files = [ "ckeditor/init", "inputs/countable_input", "jquery-ui/datepicker-pt-BR"  ]
  config.custom_css_files = [ "jquery-ui" ]
  config.use_full_model_name = false
  config.root_action = 'admin/authorial_articles#index'
end
