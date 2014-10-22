Carnival.configure do |config|

  Rails.application.config.assets.precompile += %w( carnival/* )
  config.menu =
  {
    :admin => {
      :label => "Admin",
      :class => "ssss",
      :link => "ddd",
      :subs => [
                  {
                    :label => "menu.users",
                    :class => "",
                    :link => "/users"
                  },
                  {
                    :label => "menu.messages",
                    :class => "",
                    :link => "/messages"
                  }
              ]

              }
  }
end