# == Schema Information
#
# Table name: votes
#
#  id           :bigint           not null, primary key
#  value        :integer          not null
#  votable_type :string           not null
#  votable_id   :bigint           not null
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Vote < ApplicationRecord
    validates :value, presence: true

    belongs_to :user
    belongs_to :votable, :polymorphic => true
end
