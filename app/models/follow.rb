class Follow < ActiveRecord::Base

  belongs_to :origin, :class_name => 'User', :foreign_key => 'origin_id'
  belongs_to :target, :class_name => 'User', :foreign_key => 'target_id'

end
