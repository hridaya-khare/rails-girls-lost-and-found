class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def initials
    name.split.map(&:first).first(2).join.upcase
  end
end
