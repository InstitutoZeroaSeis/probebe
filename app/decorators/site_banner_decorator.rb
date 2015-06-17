class SiteBannerDecorator < SiteBanner

  def banner_type
    t = super()
    I18n.t("activerecord.attributes.site_banner.#{t}")
  end

end
