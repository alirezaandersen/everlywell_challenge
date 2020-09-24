class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_one :website

  accepts_nested_attributes_for :website

  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    first_name + ' ' + last_name
  end
end
