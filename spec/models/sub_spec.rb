# == Schema Information
#
# Table name: subs
#
#  id           :bigint           not null, primary key
#  title        :string(100)      not null
#  description  :string(500)      not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  avatar       :string
#  image_date   :text
#  slug         :string
#
require 'rails_helper'

RSpec.describe Sub, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
