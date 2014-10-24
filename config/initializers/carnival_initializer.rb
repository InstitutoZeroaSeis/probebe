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
        }
      ]
    },
  }

  config.use_full_model_name = false
end
