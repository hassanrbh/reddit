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
#  slug                   :string
#  score                  :integer          default(0)
#
class User < ApplicationRecord
  include Gravtastic
  extend FriendlyId
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :lockable, :timeoutable, :trackable
  before_validation :adding_username
  around_create :adding_signup_user_points
  friendly_id :username, use: %i[slugged history]

  has_many :subs, :class_name => 'Sub', :primary_key => :id, :foreign_key => :moderator_id, :dependent => :destroy, inverse_of: :moderator
  has_many :posts, :class_name => 'Post', :primary_key => :id, :foreign_key => :author_id, :dependent => :destroy, inverse_of: :author
  has_many :comments, :class_name => 'Comment', :primary_key => :id, :foreign_key => :author_id, :dependent => :destroy
  has_many :votes
  
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

  def add_expected_points
    comments_score = self.comments.count
    likes_score = self.votes.where(:value => 1).count
    unlike_score = self.votes.where(:value => -1).count
    total = (comments_score*5) + (likes_score*2) - (unlike_score*2)
    self.score += total
    self.save
  end

  def avatar_thumbnail
    avatar.variant(resize: "150*150!").processed
  end

  def online?
    updated_at > 1.minutes.ago
  end

  def calculate_votes_post
    total_points = 0
    self.posts.each do |post|
      post_points = post.votes.count
      total_points += post_points
    end
    total_points
  end
  def calculate_votes_comments
    total_points = 0
    self.comments.each do |comment|
      post_points = comment.votes.count
      total_points += post_points
    end
    total_points
  end

  def should_generate_new_friendly_id?
    username_changed? || slug.blank?
  end
  private
  def adding_username
    self.username = "#{self.first_name}".concat(self.last_name)
  end

  def adding_signup_user_points
    self.score = 100
  end
end
