# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
    validates :title, :presence => true
    validates :subs, presence: { message: 'must have at least one sub'}

    belongs_to :author,
               :class_name => 'User',
               :primary_key => :id,
               :foreign_key => :author_id

    has_many :post_subs,
              :class_name => 'PostSub', :foreign_key => :post_id, :dependent => :destroy, :inverse_of => :post
    has_many :subs, :through => :post_subs

    # Is not finished Yey, still the bug of the (month date)
    def calculate_current_time
      if self.created_at.day == Time.now.day
        ("#{Time.now.hour - self.created_at.hour}h ago")
      elsif self.created_at.day < Time.now.day
        ("#{Time.now.day - self.created_at.day}d ago")
      elsif self.created_at.month < Time.now.month
        ("#{Time.now.month - sekf.created_at.month}m ago")
      end
    end

    def join_post_user
      Date.parse(self.created_at.strftime("%d/%m/%Y"))
    end
end
