class Phone < ActiveRecord::Base
  belongs_to: personal_profile

  TYPE_ENUM = [:residential, :cell, :smartphone]
  enum type: TYPE_ENUM 

end
