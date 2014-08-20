class List < ActiveRecord::Base
  has_many(:tasks)
  validates :name, :presence => true, :length => { :maximum => 50}
  before_save :downcase_name

  def downcase_name
    self.name = self.name.downcase
  end

end
