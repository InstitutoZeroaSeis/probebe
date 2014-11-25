#encoding: utf-8

require "csv"
line_of_profile = 1
line_with_problem = []
CSV.foreach('data/PlanilhaMae.csv', headers: true, col_sep: ";" ) do |row|
  line_of_profile += 1
  ActiveRecord::Base.transaction do
    first_name = row[0]
    last_name = row[1].present? ? row[1] : row[0]
    cellphone_number = row[2]
    email = row[3].present? ? row[3] : (cellphone_number.to_s + "@probebe.com.br")
    child_name = row[4]
    child_birth_date = row[5]

    if row[6] == 'M'
      child_gender = 'male'
    elsif row[6] == 'F'
      child_gender = 'female'
    else
      child_gender = nil
    end
    begin
      user = User.create!(email: email, role: 'site_user')
      user.confirm!

      profile = Profile.create!(first_name: first_name, last_name: last_name, user: user)

      profile.children << Child.create!(name: child_name, birth_date: child_birth_date, gender: child_gender)

      profile.cell_phones << CellPhone.create!(number: cellphone_number)
    rescue
      line_with_problem << (line_of_profile.to_s + row.to_s)
    end
  end
  puts line_with_problem
end