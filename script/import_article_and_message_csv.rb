#encoding: utf-8

require "csv"
admin = User.where("role = ?",  'admin').first
line_of_csv = 1
line_with_problem = []
CSV.foreach('data/PlanilhaMensagens.csv', headers: true, col_sep: ";" ) do |row|
  line_of_csv += 1
  ActiveRecord::Base.transaction do
    categories = row[0]
    parent_category_name = categories[0]

    begin
      parent_category = Category.where("lower(name) = ?", parent_category_name.downcase).first
      parent_category ||= Category.create!(name: parent_category_name.capitalize)

      sub_category = Category.where("lower(name) = ? AND parent_category_id = ?", "Base", parent_category.id).first
      sub_category ||= Category.create!(name: "Base", parent_category: parent_category )

      if row[1] == "A"
        gender = 'both'
      elsif row[1] == "M"
        gender = 'male'
      else
        gender = 'female'
      end

      baby_target_type = row[2] == "gestação" ? 'pregnancy' : 'born'

      minimum_valid_week = row[3]
      maximum_valid_week = row[4]

      message_text = row[5]

      authorial_article = Articles::AuthorialArticle.create!(text: message_text,
                                                            title:message_text.truncate(15),
                                                            category: sub_category, user: admin,
                                                            baby_target_type: baby_target_type,
                                                            minimum_valid_week: minimum_valid_week,
                                                            maximum_valid_week: maximum_valid_week)

      journalistic_article = Articles::JournalisticArticle.create!(text: message_text,
                                                                  title:message_text.truncate(15),
                                                                  category: sub_category, user: admin,
                                                                  baby_target_type: baby_target_type,
                                                                  minimum_valid_week: minimum_valid_week,
                                                                  maximum_valid_week: maximum_valid_week,
                                                                  parent_article: authorial_article,
                                                                  original_author: authorial_article.user)

      journalistic_article.messages << Message.create!(text: message_text, messageable_type: "Articles::JournalisticArticle" )
    rescue
      line_with_problem << (line_of_csv.to_s + row.to_s)
    end
  end
  puts line_with_problem
end
