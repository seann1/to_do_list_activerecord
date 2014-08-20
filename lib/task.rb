class Task < ActiveRecord::Base
  belongs_to(:list)
  validates :name, :presence => true, :length => { :maximum => 50}
  before_save :downcase_name

  def downcase_name
    self.name = self.name.downcase
  end

  def self.not_done
    where({:done => false})
  end
end
