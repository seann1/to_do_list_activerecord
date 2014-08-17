class Task < ActiveRecord::Base
  belongs_to(:list)
  validates :name, :presence => true, :length => { :maximum => 50}

  def self.not_done
    where({:done => false})
  end
end
