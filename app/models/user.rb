# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  first_name             :string           not null 
#  last_name              :string           not null
#
class User < ApplicationRecord
  include Gravtastic
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :lockable, :timeoutable, :trackable
  before_validation :adding_username

  has_many :subs, :class_name => 'Sub', :primary_key => :id, :foreign_key => :moderator_id, :dependent => :destroy, inverse_of: :moderator
  has_many :posts, :class_name => 'Post', :primary_key => :id, :foreign_key => :author_id, :dependent => :destroy, inverse_of: :author
  has_many :comments, :class_name => 'Comment', :primary_key => :id, :foreign_key => :author_id, :dependent => :destroy
  
  gravtastic :secure => true,
    :filetype => :gif,
    :size => 40,
    :default => :monsterid

  def last_login!
    if self.last_sign_in_at.hour < Time.now.hour
      ("#{Time.now.min - self.last_sign_in_at.min}hour ago")
    elsif self.last_sign_in_at.day < Time.now.day
      ("#{Time.now.day - self.last_sign_in_at.day}day ago")
    end
  end

  def avatar_thumbnail
    avatar.variant(resize: "150*150!").processed
  end

  def online?
    updated_at > 1.minutes.ago
  end

  private
  def adding_username
    self.username = "#{self.first_name}".concat(self.last_name)
  end
end
