class Author::DefaultAuthor
  DEFAULT_PROBEBE_AUTHOR_EMAIL = 'contato@probebe.com.br'

  def self.find_default_author
    User.find_by(email: DEFAULT_PROBEBE_AUTHOR_EMAIL)
  end
end
