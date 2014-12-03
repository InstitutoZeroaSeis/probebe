Carnival.configure do |config|

  Rails.application.config.assets.precompile += %w( carnival/* )
  config.menu = {
    administration: {
      label: "administration",
      link: "/admin/customers",
      class: 'administracao',
      subs: [
        {
          label: "users",
          link: "/admin/users"
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
        }
      ]
    },
  }

  config.custom_javascript_files = [ "ckeditor/init", "inputs/countable_input"  ]
  config.use_full_model_name = false
  config.root_action = 'admin/authorial_articles#index'
end
