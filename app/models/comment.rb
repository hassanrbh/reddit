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
#
class Comment < ApplicationRecord
  validates :content, presence: true

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
end
