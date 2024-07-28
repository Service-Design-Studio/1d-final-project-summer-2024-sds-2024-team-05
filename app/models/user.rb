class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

          has_many :forms

  def admin?
    self.admin
  end

  def initials
    if admin?
      "NJ"
    else
      "#{user_first_name&.first || ''}#{user_last_name&.first || ''}".upcase
    end
  end
  validates :user_first_name, :user_last_name, :user_address, :user_postal, :user_contact_number, presence: true, unless: :admin?
  validates :email, presence: true, uniqueness: true
end
