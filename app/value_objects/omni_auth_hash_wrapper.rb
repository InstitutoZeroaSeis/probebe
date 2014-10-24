class OmniAuthHashWrapper
  def initialize(auth_hash)
    @auth_hash = auth_hash
  end

  def first_name
    basic_info.first_name
  end

  def last_name
    basic_info.last_name
  end

  def email
    basic_info.email
  end

  def gender
    raw_info.try :gender
  end

  def photo_url
    basic_info.image
  end

  protected

  def basic_info
    @auth_hash.info
  end

  def extra_info
    @auth_hash.try :extra
  end

  def raw_info
    extra_info.try :raw_info
  end
end
