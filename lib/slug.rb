class Slug
  def self.from_args(*args)
    args.join('-').parameterize
  end
end
