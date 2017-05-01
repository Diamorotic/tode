class Item < ApplicationRecord
  belongs_to :list
  validates :name, presence: true
  
  def change_bool
    self.done = !self.done
  end
end
