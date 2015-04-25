class Sprite < ActiveRecord::Base
  belongs_to :owner
  belongs_to :parent
end
