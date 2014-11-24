require 'rails/generators'

module PaperTrailViews

  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def install
      template "paper_trail_views.en.yml", "config/locales/paper_trail_views.en.yml"
      template "paper_trail_views.pt-BR.yml", "config/locales/paper_trail_views.pt-BR.yml"
    end
  end

end
