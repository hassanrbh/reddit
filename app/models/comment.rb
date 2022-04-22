# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  content           :text             not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#  slug              :string
#
class Comment < ApplicationRecord
  extend FriendlyId
  validates :content, presence: true
  friendly_id :content, use: %i[slugged history]
  belongs_to :author, :class_name => 'User'
  belongs_to :post
  belongs_to :child_comments,
              :class_name => 'Comment',
              :primary_key => :id,
              :foreign_key => :parent_comment_id,
              :optional => true
  has_many :child_comments,
              :class_name => 'Comment',
              :primary_key => :id,
              :foreign_key => :parent_comment_id
  has_many :votes, as: :votable


  def calculate_comment_current_time
    if self.created_at.min < Time.now.min
      ("#{Time.now.min - self.created_at.min}m ago")
    elsif self.created_at.hour < Time.now.hour
      ("#{Time.now.hour - self.created_at.hour}h ago")
    elsif self.created_at.day < Time.now.day
      ("#{Time.now.day - self.created_at.day}d ago")
    end
  end
end
