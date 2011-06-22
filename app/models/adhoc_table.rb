# == Schema Information
#
# Table name: adhoc_tables
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class AdhocTable < ActiveRecord::Base
end
