class Component < ApplicationRecord
  belongs_to :component_category
  has_many :compositions
  has_many :foods, through: :compositions
end
